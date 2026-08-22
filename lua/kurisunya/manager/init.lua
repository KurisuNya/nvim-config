local Time = require("kurisunya.manager.time")
local Spec = require("kurisunya.manager.spec")

_G.Manager = {}
local H = {}

---@alias Manager.OptsModifierCfg { priority: number, modifier: fun(opts: table|nil): table|nil }
---@alias Manager.Stats { loaded: number, total: number, startuptime: number }

H.pack_specs = {} ---@type vim.pack.SpecResolved[]
H.plugin_specs = {} ---@type table<string, Manager.SpecResolved>
H.plugin_loaded = {} ---@type table<string, boolean>
H.before_load_hooks = {} ---@type table<string, fun()[]>
H.after_load_hooks = {} ---@type table<string, fun()[]>
H.opts_modifier_cfgs = {} ---@type table<string, Manager.OptsModifierCfg[]>
H.stats = nil ---@type Manager.Stats|nil
H.load_all_called = false ---@type boolean
H.load_all_init_done = false ---@type boolean

---@param msg string
---@param level string
H.notify = function(msg, level) vim.notify(msg, vim.log.levels[level], { title = "Manager" }) end

---@param cmd string
---@param cwd string
H.run_build_cmd = function(cmd, cwd)
  local shell = vim.env.SHELL or vim.o.shell
  local shell_args = shell:find("cmd.exe", 1, true) and "/c" or "-c"
  local result = vim.system({ shell, shell_args, cmd }, { cwd = cwd, text = true }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ""
    local stdout = result.stdout or ""
    local output = stderr ~= "" and stderr or stdout
    error(output ~= "" and output or "No output from build command.")
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = Utils.autocmd.new_group("plugin_builds"),
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end
    local path = ev.data.path

    local build = vim.tbl_get(H.plugin_specs, name, "build")
    if not build then
      return
    end
    H.notify(string.format("Running build for plugin %s", name), "INFO")
    Utils.safecall.now(function()
      if type(build) == "string" then
        H.run_build_cmd(build, path)
      else
        if not ev.data.active then
          vim.cmd.packadd(name)
        end
        build(path)
      end
    end)
    H.notify(string.format("Build for plugin %s completed", name), "INFO")
  end,
})

Manager.url = {
  ---@param repo string
  gh = function(repo) return "https://github.com/" .. repo end,
  ---@param repo string
  cb = function(repo) return "https://codeberg.org/" .. repo end,
}

Manager.event = {
  ---@type Utils.safecall.EventCfg
  VeryLazy = { event = "User", pattern = "VeryLazy" },
}

---@param name string
Manager.have = function(name) return H.plugin_specs[name] ~= nil end

---@param name string
Manager.loaded = function(name) return H.plugin_loaded[name] == true end

---@param spec Manager.Spec
Manager.add = function(spec)
  local resolved = Spec.normalize_spec(spec)
  local name = resolved[1].name
  if H.plugin_specs[name] then
    error("Plugin spec with name " .. name .. " already exists")
  end
  H.plugin_specs[name] = resolved
  for _, dep in ipairs(resolved.dependencies or {}) do
    table.insert(H.pack_specs, dep)
  end
  table.insert(H.pack_specs, resolved[1])
end

---@param name string
---@param modifier fun(opts: table|nil): table|nil
---@param options? { priority?: number }
H.register_opts_modifier = function(name, modifier, options)
  options = options or {}
  if not H.opts_modifier_cfgs[name] then
    H.opts_modifier_cfgs[name] = {}
  end
  local cfg = { modifier = modifier, priority = options.priority or 50 }
  Utils.misc.list_insert_sorted(H.opts_modifier_cfgs[name], cfg, function(x) return -x.priority end)
end

---@param type "before"|"after"
---@param name string
---@param hook fun()
H.register_load_hook = function(type, name, hook)
  local hooks
  if type == "before" then
    hooks = H.before_load_hooks
  elseif type == "after" then
    hooks = H.after_load_hooks
  else
    error("Invalid hook type: " .. type)
  end

  if not hooks[name] then
    hooks[name] = {}
  end
  table.insert(hooks[name], hook)
end

---@param name string
---@param opts table
---@param options? {extend?: string|string[], priority?: number}
Manager.opts_extend = function(name, opts, options)
  options = options or {}
  vim.validate("name", name, "string", false)
  vim.validate("opts", opts, "table", false)
  local extend, priority = options.extend, options.priority
  extend = type(extend) == "string" and { extend } or extend --[=[@as string[]|nil]=]
  for i, key in ipairs(extend or {}) do
    vim.validate("options.extend[" .. i .. "]", key, "string", false)
  end
  vim.validate("options.priority", priority, "number", true)

  local modifier = function(old_opts)
    old_opts = old_opts or {}
    local t = vim.tbl_deep_extend("force", old_opts, opts)
    for _, key in ipairs(extend or {}) do
      local path = vim.split(key, ".", { plain = true })
      local base = vim.tbl_get(old_opts, unpack(path))
      local add = vim.tbl_get(opts, unpack(path))
      base = base == nil and {} or base
      if not vim.islist(base) or not vim.islist(add) then
        error("Cannot extend non-list option: " .. key)
      end
      local merged = vim.list_extend({}, base)
      merged = vim.list_extend(merged, add)
      Utils.misc.tbl_set(t, merged, unpack(path))
    end
    return t
  end
  H.register_opts_modifier(name, modifier, { priority = priority })
end

---@param name string
---@param fn fun()
Manager.before_loaded = function(name, fn)
  vim.validate("name", name, "string", false)
  vim.validate("fn", fn, "function", false)
  if Manager.loaded(name) then
    error("Plugin " .. name .. " is already loaded")
  else
    H.register_load_hook("before", name, fn)
  end
end

---@param name string
---@param fn fun()
Manager.on_loaded = function(name, fn)
  vim.validate("name", name, "string", false)
  vim.validate("fn", fn, "function", false)
  if Manager.loaded(name) then
    fn()
  else
    H.register_load_hook("after", name, fn)
  end
end

---@param spec Manager.SpecResolved
H.do_load_spec = function(spec)
  local name = spec[1].name
  for _, hook in ipairs(H.before_load_hooks[name] or {}) do
    Utils.safecall.now(hook)
  end

  local specs = {}
  for _, dep in ipairs(spec.dependencies or {}) do
    if Manager.have(dep.name) then
      H.load_spec_by_name(dep.name)
    else
      table.insert(specs, dep)
    end
  end

  table.insert(specs, spec[1])
  vim.pack.add(specs, { load = true, confirm = false })

  local opts = spec.opts
  if type(opts) == "function" then
    opts = opts()
    vim.validate("spec.opts", opts, "table", false)
  end
  for i, cfg in ipairs(H.opts_modifier_cfgs[name] or {}) do
    opts = cfg.modifier(opts)
    vim.validate("spec.opts after modifier " .. i, opts, "table", true)
  end

  if opts and not spec.config then
    error(name .. ": spec.opts is set but spec.config is nil")
  end
  if spec.config then
    spec.config(opts or {})
  end

  for _, hook in ipairs(H.after_load_hooks[name] or {}) do
    Utils.safecall.now(hook)
  end
end

---@param spec Manager.SpecResolved
H.load_spec = function(spec)
  local name = spec[1].name
  if H.plugin_loaded[name] then
    return
  end
  H.plugin_loaded[name] = true

  local ok, err = xpcall(
    function() H.do_load_spec(spec) end,
    function(e) return debug.traceback(tostring(e), 2) end
  )

  if not ok then
    H.plugin_loaded[name] = false
    error(err)
  end
end

---@param name string
H.load_spec_by_name = function(name)
  local spec = H.plugin_specs[name]
  if not spec then
    error("Plugin spec with name " .. name .. " does not exist")
  end
  H.load_spec(spec)
end

---@return boolean missing
H.install_missing = function()
  local installed = {}
  for _, p in ipairs(vim.pack.get(nil, { info = false })) do
    installed[p.spec.name] = true
  end

  local missing = vim.tbl_filter(function(s) return not installed[s.name] end, H.pack_specs)
  vim.pack.add(missing, { load = false, confirm = false })
  return #missing > 0
end

H.compute_stats = function()
  local plugins = vim.pack.get(nil, { info = false })
  local loaded = vim.tbl_filter(function(p) return p.active end, plugins)
  return {
    loaded = #loaded,
    total = #plugins,
    startuptime = Time.elapsed_ms(),
  }
end

---@return Manager.Stats
Manager.stats = function()
  if not H.stats then
    error("Manager.stats() can only be called after Manager.load_all()")
  end
  return H.stats
end

---@return string[]
Manager.not_managed = function()
  local managed = {}
  for _, spec in ipairs(H.pack_specs) do
    managed[spec.name] = true
  end

  local installed = vim.pack.get(nil, { info = false })
  local names = vim.tbl_map(function(p) return p.spec.name end, installed)
  return vim.tbl_filter(function(n) return not managed[n] end, names)
end

---@param name string
Manager.load = function(name)
  vim.validate("name", name, "string", false)
  if not H.load_all_init_done then
    error("Manager.load() can only be called after Manager.load_all() init phase is done")
  end
  H.load_spec_by_name(name)
end

Manager.load_all = function()
  if H.load_all_called then
    error("Manager.load_all() should only be called once")
  end
  H.load_all_called = true

  -- install missing plugins and restart
  if H.install_missing() then
    Utils.safecall.now(function() vim.api.nvim_command("restart! +qall!") end)
  end

  local specs = vim.tbl_values(H.plugin_specs)
  Utils.misc.list_sort_stable(specs, function(x) return -x.priority end)

  -- run init functions
  for _, spec in ipairs(specs) do
    local init = spec.init
    if init then
      Utils.safecall.now(init)
    end
  end
  H.load_all_init_done = true

  -- split into startup, event, filetype plugins
  ---@type Manager.SpecResolved[]
  local startup_specs = {}
  ---@type Manager.SpecResolved[]
  local event_specs = {}
  ---@type Manager.SpecResolved[]
  local filetype_specs = {}
  for _, spec in ipairs(specs) do
    if not spec.lazy then
      table.insert(startup_specs, spec)
    elseif spec.event then
      table.insert(event_specs, spec)
    elseif spec.filetype then
      table.insert(filetype_specs, spec)
    end
  end

  -- register event plugins
  for _, spec in ipairs(event_specs) do
    Utils.safecall.when_events(spec.event, function() H.load_spec(spec) end)
  end

  -- register filetype plugins
  for _, spec in ipairs(filetype_specs) do
    Utils.safecall.when_filetypes(spec.filetype, function() H.load_spec(spec) end)
  end

  -- register VeryLazy event
  Utils.safecall.later(function() vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" }) end)

  -- load startup plugins
  for _, spec in ipairs(startup_specs) do
    Utils.safecall.now(function() H.load_spec(spec) end)
  end

  -- compute stats
  H.stats = H.compute_stats()
end
