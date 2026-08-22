local store = require("kurisunya.manager.ui.store")
local view = require("kurisunya.manager.ui.view")
local actions = require("kurisunya.manager.ui.actions")

local M = {}

---@param raw table[]?
---@return Ui.Plugin[]
local function force_plugins(raw)
  local out = {}
  for _, p in ipairs(raw or {}) do
    out[#out + 1] = store.from_pack(p)
  end
  return store.sort_by_name(out)
end

local api = vim.api

local state = {
  winid = nil,
  bufnr = nil,
  autocmd = nil,
  update_autocmds = nil,
  checking = false,
  check_id = 0,
  status = "",
  plugins = {},
  commits = {},
  expanded = {},
  update_status = {},
  resize_group = nil,
}

---@param installed_plugins Ui.Plugin[]
local function compute_not_managed(installed_plugins)
  local manager = _G.Manager
  local not_managed_names = manager and manager.not_managed and manager.not_managed() or {}
  local managed_set = {}
  for _, n in ipairs(not_managed_names) do
    managed_set[n] = true
  end
  local result = {}
  for _, p in ipairs(installed_plugins or {}) do
    if managed_set[p.name] then
      result[#result + 1] = p
    end
  end
  return result
end

---@param state Ui.State
local function render(state)
  if not (state.bufnr and api.nvim_buf_is_valid(state.bufnr)) then
    return
  end
  local vm = store.build_view_model(state, compute_not_managed(state.plugins))
  local data = view.static_view(vm)
  view.apply(state.bufnr, data)
  state._view_data = data -- 供 plugin_at/jump 使用
end

--- 节流渲染: leading + trailing(合并高频 emit_view, 终帧必达)
local RENDER_THROTTLE_MS = 100
local render_last = 0
local render_pending = false

local function throttled_render(state)
  if not (state.bufnr and api.nvim_buf_is_valid(state.bufnr)) then
    return
  end
  local now = vim.uv.hrtime() / 1e6
  local elapsed = now - render_last
  if elapsed >= RENDER_THROTTLE_MS then
    render_last = now
    render(state)
  elseif not render_pending then
    render_pending = true
    vim.defer_fn(function()
      render_pending = false
      if state.bufnr and api.nvim_buf_is_valid(state.bufnr) then
        render_last = vim.uv.hrtime() / 1e6
        render(state)
      end
    end, RENDER_THROTTLE_MS - elapsed)
  end
end

actions.on_view = function(state) throttled_render(state) end

---@param name string
---@param fn fun()
---@param desc string
local function map(name, fn, desc)
  vim.keymap.set("n", name, fn, { buffer = state.bufnr, silent = true, nowait = true, desc = desc })
end

--- 单点守卫: 窗口有效检查集中于此
---@param fn fun()
---@return fun()
local function guarded(fn)
  return function()
    if not (state.winid and api.nvim_win_is_valid(state.winid)) then
      return
    end
    fn()
  end
end

local function plugin_at_cursor()
  if not (state.winid and api.nvim_win_is_valid(state.winid)) then
    return nil
  end
  local row = api.nvim_win_get_cursor(state.winid)[1]
  local data = state._view_data
  if not data then
    return nil
  end
  return view.plugin_at(data, row)
end

local function clear_update_autocmds()
  if not state.update_autocmds then
    return
  end
  for _, autocmd in ipairs(state.update_autocmds) do
    pcall(api.nvim_del_autocmd, autocmd)
  end
  state.update_autocmds = nil
end

local function close()
  if state.autocmd then
    pcall(api.nvim_del_autocmd, state.autocmd)
    state.autocmd = nil
  end
  if state.winid and api.nvim_win_is_valid(state.winid) then
    api.nvim_win_close(state.winid, true)
  end
  state.winid = nil
  state.bufnr = nil
  state.check_id = state.check_id + 1
  state.checking = false
  if state.resize_group then
    pcall(api.nvim_del_augroup_by_id, state.resize_group)
    state.resize_group = nil
  end
  clear_update_autocmds()
end

function M.close() close() end

local function handle_pack_changed(status)
  return function(ev)
    local data = ev.data or {}
    if data.kind ~= "update" or not data.spec then
      return
    end
    if state.update_status[data.spec.name] == nil then
      return
    end
    state.update_status[data.spec.name] = status
    actions.emit_view(state)
  end
end

local function setup_update_autocmds()
  if state.update_autocmds then
    return
  end
  state.update_autocmds = {
    api.nvim_create_autocmd("PackChangedPre", { callback = handle_pack_changed("updating") }),
    api.nvim_create_autocmd("PackChanged", { callback = handle_pack_changed("updated") }),
  }
end

local function update_current()
  local name = plugin_at_cursor()
  if not name then
    return
  end
  local plugin = store.find_plugin(state, name)
  if plugin and store.is_pending(plugin) then
    actions.update(state, { name })
  else
    vim.notify(("vim.pack: %s has no pending update"):format(name), vim.log.levels.INFO)
  end
end

local function update_all()
  local names = {}
  for _, plugin in ipairs(state.plugins or {}) do
    if store.is_pending(plugin) then
      names[#names + 1] = plugin.name
    end
  end
  actions.update(state, names)
end

local function uninstall_current()
  local name = plugin_at_cursor()
  if not name then
    return
  end
  actions.uninstall(state, name)
end

local function refresh(fetch)
  if fetch then
    if store.begin_refresh(state) then
      state.status = "fetching remotes"
      state.commits = {}
      state.update_status = {}
      -- 清空 rev_to: 视为未检查 → Updates 区立即清空, 等 fetch 完成后重新判定
      for _, plugin in ipairs(state.plugins or {}) do
        plugin.rev_to = nil
      end
      actions.emit_view(state)
      actions.fetch_check(state, state.check_id)
    end
  else
    actions.local_check(state)
  end
end

local function clean_unmanaged()
  local names = vim.tbl_map(function(p) return p.name end, compute_not_managed(state.plugins))
  if #names == 0 then
    return
  end
  local prompt = string.format("Uninstall %d not managed plugins from disk?", #names)
  local choice = vim.fn.confirm(prompt, "&Uninstall\n&Cancel", 2)
  if choice ~= 1 then
    return
  end
  actions.clean(state, names)
end

local function toggle_details()
  local name = plugin_at_cursor()
  if not name then
    return
  end
  state.expanded[name] = not state.expanded[name]
  actions.emit_view(state)
  local data = state._view_data
  if state.winid and data and data.name_to_line[name] then
    local row = data.name_to_line[name]
    local col = data.name_cols and data.name_cols[row] or 0
    api.nvim_win_set_cursor(state.winid, { row, col })
  end
end

local function setup_keymaps()
  map("q", guarded(close), "Close")
  map("<Esc>", guarded(close), "Close")
  map("R", guarded(function() refresh(true) end), "Refresh updates")
  map("u", guarded(update_current), "Update plugin")
  map("U", guarded(update_all), "Update all pending")
  map("x", guarded(uninstall_current), "Uninstall plugin")
  map("X", guarded(clean_unmanaged), "Clean not managed")
  map("<CR>", guarded(toggle_details), "Toggle details")
end

local function compute_layout()
  local columns = vim.o.columns
  local screen_lines = vim.o.lines
  local width = math.min(100, math.max(64, math.floor(columns * 0.82)))
  local height = math.min(32, math.max(18, math.floor(screen_lines * 0.72)))
  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((screen_lines - height) / 2),
    col = math.floor((columns - width) / 2),
  }
end

local function resize()
  if not (state.winid and api.nvim_win_is_valid(state.winid)) then
    return
  end
  api.nvim_win_set_config(state.winid, compute_layout())
end

---@param opts? { fetch?: boolean }
M.open = function(opts)
  opts = opts or {}
  vim.validate("opts", opts, "table", false)

  if state.winid and api.nvim_win_is_valid(state.winid) then
    api.nvim_set_current_win(state.winid)
    return
  end

  state.bufnr = api.nvim_create_buf(false, true)
  vim.bo[state.bufnr].buftype = "nofile"
  vim.bo[state.bufnr].bufhidden = "wipe"
  vim.bo[state.bufnr].swapfile = false
  vim.bo[state.bufnr].filetype = "pack-float"

  local win_cfg = vim.tbl_extend("force", {
    style = "minimal",
    title = " vim.pack ",
    title_pos = "center",
  }, compute_layout())
  state.winid = api.nvim_open_win(state.bufnr, true, win_cfg)

  vim.wo[state.winid].cursorline = true
  vim.wo[state.winid].wrap = true
  vim.wo[state.winid].linebreak = true
  vim.wo[state.winid].breakindent = true

  state.resize_group = Utils.autocmd.new_group("pack_float_resize")
  api.nvim_create_autocmd("VimResized", { group = state.resize_group, callback = resize })

  -- 初始数据(info=false, 0ms)
  local ok, plugins_or_err = pcall(vim.pack.get, nil, { info = false })
  state.plugins = ok and force_plugins(plugins_or_err) or {}
  state.status = ok and "" or tostring(plugins_or_err)

  setup_keymaps()
  setup_update_autocmds()
  render(state)

  local captured_win = state.winid
  state.autocmd = api.nvim_create_autocmd("WinClosed", {
    once = true,
    callback = function(ev)
      if vim.fn.str2nr(ev.match) == captured_win then
        state.autocmd = nil
        state.winid = nil
        state.bufnr = nil
        state.check_id = state.check_id + 1
        state.checking = false
        if state.resize_group then
          pcall(api.nvim_del_augroup_by_id, state.resize_group)
          state.resize_group = nil
        end
        clear_update_autocmds()
      end
    end,
  })

  if opts.fetch ~= false then
    refresh(true)
  end
end

api.nvim_create_user_command(
  "Pack",
  function(command) M.open({ fetch = not command.bang }) end,
  { bang = true, desc = "Open vim.pack UI" }
)

return M
