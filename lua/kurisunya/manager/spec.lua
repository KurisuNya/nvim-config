--- NOTE: When lazy=true, and event/filetype is not set, the plugin will be not be loaded automatically,
-- you need to add it to other plugin's dependencies or load it manually with Manager.load function.

---@class Manager.Spec
---@field [1] string|vim.pack.Spec plugin spec for vim.pack
---@field dependencies? (string|vim.pack.Spec)[] dependencies for vim.pack
---@field build? string|fun(path: string) build command/function, will be called when the plugin is installed or updated
---@field init? fun() init function, will be called before ANY plugin is loaded
---@field opts? table|fun(): table  options table/function
---@field config? fun(opts: table) config function, if nil, plugin will be loaded without config
---@field event? string|string[]|Utils.safecall.EventCfg|Utils.safecall.EventCfg[] load on event(s)
---@field filetype? string|string[] load on filetype(s)
---@field priority? number only useful for lazy=false plugins, default is 50
---@field lazy? boolean whether to load the plugin lazily, default is true

---@class Manager.SpecResolved
---@field [1] vim.pack.SpecResolved
---@field dependencies? vim.pack.SpecResolved[]
---@field build? string|fun(path: string)
---@field init? fun()
---@field opts? table|fun(): table
---@field config? fun(opts: table)
---@field event? Utils.safecall.EventCfg[]
---@field filetype? string[]
---@field priority number
---@field lazy boolean

local SPEC_KEYS =
  { 1, "dependencies", "build", "init", "opts", "config", "event", "filetype", "priority", "lazy" }
local DEFAULT_PRIORITY = 50

---@param spec string|vim.pack.Spec
---@return vim.pack.SpecResolved
local function normalize_vim_pack_spec(spec)
  local function is_nonempty_string(x) return type(x) == "string" and x ~= "" end
  local function is_version(x)
    return type(x) == "string" or (type(x) == "table" and pcall(x.has, x, "1"))
  end
  spec = type(spec) == "string" and { src = spec } or spec
  vim.validate("spec", spec, "table")
  vim.validate("spec.src", spec.src, is_nonempty_string, false, "non-empty string")
  local name = spec.name or spec.src:gsub("%.git$", "")
  name = (type(name) == "string" and name or ""):match("[^/]+$") or ""
  vim.validate("spec.name", name, is_nonempty_string, true, "non-empty string")
  vim.validate("spec.version", spec.version, is_version, true, "string or vim.VersionRange")
  return { src = spec.src, name = name, version = spec.version, data = spec.data }
end

local M = {}

---@param spec Manager.Spec
---@return Manager.SpecResolved spec
M.normalize_spec = function(spec)
  vim.validate("spec", spec, "table", false)
  for k, _ in pairs(spec) do
    if not vim.tbl_contains(SPEC_KEYS, k) then
      error(string.format("spec.%s is not a valid key", k))
    end
  end

  spec = vim.deepcopy(spec)
  -- plugin spec
  spec[1] = normalize_vim_pack_spec(spec[1])
  -- dependencies
  vim.validate("spec.dependencies", spec.dependencies, vim.islist, true, "list")
  if spec.dependencies then
    for i, dep in ipairs(spec.dependencies) do
      spec.dependencies[i] = normalize_vim_pack_spec(dep)
    end
    spec.dependencies = #spec.dependencies > 0 and spec.dependencies or nil
  end
  -- build, init, opts, config
  vim.validate("spec.build", spec.build, { "string", "function" }, true)
  vim.validate("spec.init", spec.init, "function", true)
  vim.validate("spec.opts", spec.opts, { "table", "function" }, true)
  vim.validate("spec.config", spec.config, "function", true)
  if spec.opts and not spec.config then
    error("spec.opts is set but spec.config is nil, please provide a config function")
  end
  -- event, filetype
  spec.event = type(spec.event) == "string" and { spec.event } or spec.event
  vim.validate("spec.event", spec.event, "table", true)
  if spec.event then
    spec.event = vim.islist(spec.event) and spec.event or { spec.event }
    spec.event = type(spec.event[1]) == "string" and { { event = spec.event } } or spec.event
  end
  vim.validate("spec.filetype", spec.filetype, { "string", "table" }, true)
  if spec.filetype then
    spec.filetype = type(spec.filetype) == "string" and { spec.filetype } or spec.filetype
  end
  if spec.event and spec.filetype then
    error("spec.event and spec.filetype are mutually exclusive")
  end
  -- priority
  vim.validate("spec.priority", spec.priority, "number", true)
  spec.priority = spec.priority or DEFAULT_PRIORITY
  -- lazy
  vim.validate("spec.lazy", spec.lazy, "boolean", true)
  if spec.lazy == nil then
    spec.lazy = true
  end

  return {
    spec[1],
    dependencies = spec.dependencies,
    build = spec.build,
    init = spec.init,
    opts = spec.opts,
    config = spec.config,
    event = spec.event,
    filetype = spec.filetype,
    priority = spec.priority,
    lazy = spec.lazy,
  }
end

return M
