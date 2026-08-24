local H = {}

---@alias Utils.safecall.TraceInfo {name: string, msg: string}

---@class Utils.safecall.EventCfg
---@field event string|string[]
---@field pattern? string|string[]

---@param cfg Utils.safecall.EventCfg
H.validate_event = function(cfg)
  vim.validate("cfg", cfg, "table")
  local event, pattern = cfg.event, cfg.pattern
  -- event
  vim.validate("cfg.event", event, { "string", "table" }, false)
  if type(event) == "table" then
    vim.validate("cfg.event", event, vim.islist, false, "list")
    for i, e in ipairs(event) do
      vim.validate("cfg.event[" .. i .. "]", e, "string", false)
    end
  end
  -- pattern
  vim.validate("cfg.pattern", pattern, { "string", "table" }, true)
  if type(pattern) == "table" then
    vim.validate("cfg.pattern", pattern, vim.islist, false, "list")
    for i, p in ipairs(pattern) do
      vim.validate("cfg.pattern[" .. i .. "]", p, "string", false)
    end
  end
end

---@param fn fun() Function to execute (without arguments).
---@param trace? Utils.safecall.TraceInfo Traceback of the calling function
---@return boolean success Whether the function executed successfully
H.execute_now = function(fn, trace)
  local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e) .. "\n", 2) end)
  if ok then
    return true
  end
  local msg = ""
  if trace then
    msg = "\n\nTraceback of `" .. trace.name .. "()` call:\n" .. trace.msg
  end
  vim.notify("Error during execution: " .. err .. msg, vim.log.levels.WARN)
  return false
end

---@type {f: fun(), trace: Utils.safecall.TraceInfo}[]
H.later_cache = {}

H.execute_later = function()
  local timer = assert(vim.uv.new_timer())
  local f
  f = vim.schedule_wrap(function()
    local cb = H.later_cache[1]
    if cb == nil then
      if not timer:is_closing() then
        timer:close()
      end
      return
    end

    table.remove(H.later_cache, 1)
    H.execute_now(cb.f, cb.trace)
    timer:start(1, 0, f)
  end)
  -- Space out "later" executions to be sure that they don't block anything
  timer:start(1, 0, f)
end

---@param cfgs Utils.safecall.EventCfg[] List of event cfgs to trigger execution of `f`.
---@param fn fun() Function to execute (without arguments).
---@param trace? Utils.safecall.TraceInfo Traceback of the calling function
H.make_defer_autocmds = function(cfgs, fn, trace)
  local au_ids = {}
  local function cb()
    -- Execute exactly once, not once per event or pattern match
    -- Delete before executing `f` to account for nested events
    for _, au_id in ipairs(au_ids) do
      pcall(vim.api.nvim_del_autocmd, au_id)
    end
    H.execute_now(fn, trace)
  end

  local group = vim.api.nvim_create_augroup("kurisunya_utils_safecall", { clear = false })
  for _, cfg in ipairs(cfgs) do
    local opts = { group = group, pattern = cfg.pattern, callback = cb, nested = true }
    local au_id = vim.api.nvim_create_autocmd(cfg.event, opts)
    table.insert(au_ids, au_id)
  end
end

---@param buf_id integer Buffer ID to check for filetype redetection.
---@param ft_arr string[] Filetypes to force execution of |ftplugin| scripts for
---@param needs_redetect boolean Whether to run |filetype-detect| for the buffer.
H.redetect_filetypes = function(buf_id, ft_arr, needs_redetect)
  if not vim.api.nvim_buf_is_loaded(buf_id) then
    return
  end
  vim.api.nvim_buf_call(buf_id, function()
    -- Try detecting new filetypes
    if needs_redetect and vim.bo.buftype == "" then
      vim.cmd("filetype detect")
    end
    -- Force execution of 'ftplugin' scripts for matched filetypes
    if vim.tbl_contains(ft_arr, vim.bo.filetype) then
      vim.bo.filetype = vim.bo.filetype
    end
  end)
end

local M = {}

---@param fn fun() Function to execute (without arguments).
---@return boolean success Whether the function executed successfully
M.now = function(fn)
  vim.validate("f", fn, "function")
  return H.execute_now(fn)
end

---@param fn fun() Function to execute (without arguments).
M.later = function(fn)
  vim.validate("f", fn, "function")
  local trace = { name = "Utils.safecall.later", msg = debug.traceback("", 2) }
  if #H.later_cache == 0 then
    vim.schedule(H.execute_later)
  end
  table.insert(H.later_cache, { f = fn, trace = trace })
end

---@param cfgs Utils.safecall.EventCfg[] List of event cfgs to trigger execution of `f`.
---@param fn fun() Function to execute (without arguments).
M.when_events = function(cfgs, fn)
  vim.validate("cfgs", cfgs, vim.islist, false, "list")
  for _, cfg in ipairs(cfgs) do
    H.validate_event(cfg)
  end
  local trace = { name = "Utils.safecall.on_event", msg = debug.traceback("", 2) }
  H.make_defer_autocmds(cfgs, fn, trace)
end

---@param filetypes string[] Filetypes to trigger execution of `f`.
---@param fn fun() Function to execute (without arguments).
M.when_filetypes = function(filetypes, fn)
  vim.validate("filetype", filetypes, vim.islist, false, "list")
  if #filetypes == 0 then
    return
  end
  local is_nonempty_string = function(x) return type(x) == "string" and x ~= "" end
  for i, ft in ipairs(filetypes) do
    vim.validate("filetype[" .. i .. "]", ft, is_nonempty_string, false, "non-empty string")
  end

  local trace = { name = "Utils.safecall.on_filetype", msg = debug.traceback("", 2) }
  -- NOTE: Needs `vim.schedule_wrap()` for a correct redetect. This also
  -- prompts using `H.execute_now` and not rely on `H.make_defer_autocmds`.
  local f_and_redetect = vim.schedule_wrap(function()
    -- Look out for new 'ftdetect' scripts by comparing before and after
    local ftdetect_scripts_before = vim.api.nvim_get_runtime_file("ftdetect/*.{vim,lua}", true)
    local ok = H.execute_now(fn, trace)
    -- Skip redetect if there was error or detection is disabled
    if not (ok and vim.g.did_load_filetypes == 1) then
      return
    end
    local ftdetect_scripts_after = vim.api.nvim_get_runtime_file("ftdetect/*.{vim,lua}", true)
    local needs_redetect = not vim.deep_equal(ftdetect_scripts_before, ftdetect_scripts_after)
    for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
      H.redetect_filetypes(buf_id, filetypes, needs_redetect)
    end
  end)
  local cfgs = { { event = "FileType", pattern = filetypes } }
  H.make_defer_autocmds(cfgs, f_and_redetect, trace)
end

return M
