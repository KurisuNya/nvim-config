---@class Ui.Plugin
---@field name string
---@field src string
---@field version string|vim.VersionRange?
---@field version_str? string
---@field path string
---@field rev string
---@field rev_to? string -- nil = 未获取(合法态, 非非法输入)
---@field active boolean

---@class Ui.Commit
---@field hash string
---@field message string
---@field conventional_prefix? string
---@field time_range? string

---@class Ui.Section
---@field title string
---@field kind "pending"|"clean"|"inactive"
---@field plugins Ui.Plugin[]
---@field checking? boolean -- 仅 Updates 区: 刷新中显示 checking...

---@class Ui.SectionPlugin          ← view 渲染所需的状态并入 entry(布局知识隔离的完整契约)
---@field plugin Ui.Plugin
---@field expanded boolean
---@field progress? string
---@field commits? Ui.Commit[]     -- nil=loading, {} = no new commits

---@class Ui.Section2
---@field title string
---@field kind "pending"|"clean"|"inactive"
---@field entries Ui.SectionPlugin[]
---@field checking? boolean

---@class Ui.ViewModel
---@field status string
---@field sections Ui.Section2[]
---@field line_to_name table<integer, string>
---@field name_to_line table<string, integer>

local M = {}

---@param p vim.pack.PlugData
---@return Ui.Plugin
M.from_pack = function(p)
  return {
    name = p.spec.name,
    src = p.spec.src,
    version = p.spec.version,
    version_str = p.spec.version_str or nil, -- vim.pack get info=true 才有的解析结果
    path = p.path,
    rev = p.rev or "",
    rev_to = p.rev_to,
    active = p.active == true,
  }
end

---@param plugin Ui.Plugin
---@param rev_to string?
---@return Ui.Plugin
M.with_rev_to = function(plugin, rev_to)
  return {
    name = plugin.name,
    src = plugin.src,
    version = plugin.version,
    version_str = plugin.version_str,
    path = plugin.path,
    rev = plugin.rev,
    rev_to = rev_to,
    active = plugin.active,
  }
end

---@param plugin Ui.Plugin
---@return boolean
M.is_pending = function(plugin) return plugin.rev_to ~= nil and plugin.rev ~= plugin.rev_to end

---@param list Ui.Plugin[]
---@return Ui.Plugin[]
M.sort_by_name = function(list)
  table.sort(list, function(a, b) return a.name < b.name end)
  return list
end

---@param plugins Ui.Plugin[]
---@return {[1]: Ui.Plugin[], [2]: Ui.Plugin[], [3]: Ui.Plugin[]}
M.classify = function(plugins)
  local pending, clean, inactive = {}, {}, {}
  for _, plugin in ipairs(plugins) do
    if M.is_pending(plugin) then
      pending[#pending + 1] = plugin
    elseif plugin.active then
      clean[#clean + 1] = plugin
    else
      inactive[#inactive + 1] = plugin
    end
  end
  M.sort_by_name(pending)
  M.sort_by_name(clean)
  M.sort_by_name(inactive)
  return pending, clean, inactive
end

--- 领域解析: git log 输出行 → Ui.Commit[]
---@param lines string[]
---@return Ui.Commit[]
M.parse_commits = function(lines)
  local commits = {}
  for _, line in ipairs(lines) do
    local text = tostring(line or "")
    local hash, message = text:match("^(%x+)%s*(.*)$")
    hash = hash or text
    message = message or ""
    local prefix = message:match("^[%w_-]+%b()!:") and message:match("^[%w_-]+%b()!:")
      or message:match("^[%w_-]+%b():") and message:match("^[%w_-]+%b():")
      or message:match("^[%w_-]+!:") and message:match("^[%w_-]+!:")
      or message:match("^[%w_-]+:") and message:match("^[%w_-]+:")
    local time_range = message:match("%([^()]+%)$")
    commits[#commits + 1] = {
      hash = hash,
      message = message,
      conventional_prefix = prefix,
      time_range = time_range,
    }
  end
  return commits
end

---@param state Ui.State
---@param not_managed? Ui.Plugin[]
---@return Ui.ViewModel
M.build_view_model = function(state, not_managed)
  local pending, clean, inactive = M.classify(state.plugins or {})

  local function entries(plugins)
    local out = {}
    for _, plugin in ipairs(plugins) do
      out[#out + 1] = {
        plugin = plugin,
        expanded = state.expanded[plugin.name] == true,
        progress = state.update_status[plugin.name],
        commits = state.commits[plugin.name], -- nil=loading, {}=no new commits
      }
    end
    return out
  end

  local sections = {}
  if not_managed and #not_managed > 0 then
    sections[#sections + 1] = {
      title = "Not Managed",
      kind = "not_managed",
      entries = entries(not_managed),
    }
  end
  sections[#sections + 1] = {
    title = "Updates",
    kind = "pending",
    entries = entries(pending),
    checking = state.checking,
  }
  sections[#sections + 1] = {
    title = "Loaded",
    kind = "clean",
    entries = entries(clean),
  }
  sections[#sections + 1] = {
    title = "Inactive",
    kind = "inactive",
    entries = entries(inactive),
  }

  return {
    status = state.status or "",
    sections = sections,
  }
end

--- 原子重入控制(check-and-set)
---@param state Ui.State
---@param name string
---@return Ui.Plugin?
M.find_plugin = function(state, name)
  for _, plugin in ipairs(state.plugins or {}) do
    if plugin.name == name then
      return plugin
    end
  end
  return nil
end

---@param state Ui.State
---@return boolean started
M.begin_refresh = function(state)
  if state.checking then
    return false
  end
  state.checking = true
  state.check_id = state.check_id + 1
  return true
end

---@param state Ui.State
M.end_refresh = function(state) state.checking = false end

return M
