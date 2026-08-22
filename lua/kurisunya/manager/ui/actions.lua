local store = require("kurisunya.manager.ui.store")

local M = {}

---@param text string
---@return string[]
local function split_lines(text)
  local lines = {}
  for line in (text or ""):gmatch("[^\n]+") do
    lines[#lines + 1] = line
  end
  return lines
end

--- 异步回调统一入口: safecall.now 兜底意外错误 → notify, 不崩会话
---@param fn fun()
local function async_call(fn)
  vim.schedule(function() Utils.safecall.now(fn) end)
end

---@param state Ui.State
---@param check_id integer
---@param fn fun()
local function if_current(state, check_id, fn)
  if state.check_id ~= check_id then
    return false
  end
  fn()
  return true
end

---@param state Ui.State
---@param check_id integer
---@param fn fun()
local function guarded_async(state, check_id, fn)
  async_call(function() if_current(state, check_id, fn) end)
end

---@param raw table[]?
---@return Ui.Plugin[]
local function force_plugins(raw)
  local out = {}
  for _, p in ipairs(raw or {}) do
    out[#out + 1] = store.from_pack(p)
  end
  return store.sort_by_name(out)
end

---@param plugins Ui.Plugin[]
---@param name string
---@param new_plugin Ui.Plugin
---@return Ui.Plugin[]
local function replace_plugin(plugins, name, new_plugin)
  for i, p in ipairs(plugins) do
    if p.name == name then
      plugins[i] = new_plugin
    end
  end
  return plugins
end

---@param state Ui.State
---@param check_id integer
M.fetch_check = function(state, check_id)
  local total = #state.plugins
  local remaining = total
  local failures = 0

  if total == 0 then
    M.finish_refresh(state, check_id, failures)
    return
  end

  -- 阶段1: 并发 fetch 全部
  local _ = check_id -- 闭包捕获, 供回调比对
  for _, plugin in ipairs(state.plugins) do
    vim.system({
      "git",
      "-C",
      plugin.path,
      "fetch",
      "--quiet",
      "--tags",
      "--force",
      "--recurse-submodules=yes",
      "origin",
    }, {}, function(fetch_result)
      guarded_async(state, check_id, function()
        if fetch_result.code ~= 0 then
          failures = failures + 1
        end
        remaining = remaining - 1
        state.status = ("fetching remotes %d/%d"):format(total - remaining, total)
        M.emit_view(state)
        if remaining == 0 then
          M.finish_refresh(state, check_id, failures)
        end
      end)
    end)
  end
end

--- 阶段2: fetch 完成后批量推断 rev_to
--- 无 version → git rev-parse origin/HEAD; 有 version → vim.pack.get 兜底
--- 全部完成后 emit_view(触发 set_plugins+render) + load_commits
---@param state Ui.State
---@param check_id integer
---@param failures integer
M.finish_refresh = function(state, check_id, failures)
  if not if_current(state, check_id, function() end) then
    return
  end

  store.end_refresh(state)
  state.status = failures > 0 and ("ready, %d fetch failed"):format(failures) or "ready"
  M.emit_view(state)

  local refresh_ok, refresh = pcall(vim.pack.get, nil, { info = false })
  if not refresh_ok then
    return
  end

  local plugins = force_plugins(refresh)
  state.plugins = plugins

  local remaining = #plugins
  local function maybe_finish()
    remaining = remaining - 1
    if remaining <= 0 then
      M.emit_view(state)
      for _, plugin in ipairs(state.plugins or {}) do
        if store.is_pending(plugin) then
          M.load_commits(state, plugin)
        end
      end
    end
  end

  for _, plugin in ipairs(plugins) do
    local name, version = plugin.name, plugin.version
    if version then
      vim.defer_fn(function()
        async_call(function()
          if not if_current(state, check_id, function() end) then
            return
          end
          local ok, pd = pcall(vim.pack.get, { name }, { offline = true })
          local new_p = (ok and pd and pd[1]) and store.from_pack(pd[1]) or plugin
          replace_plugin(state.plugins, name, new_p)
          maybe_finish()
        end)
      end, 0)
    else
      vim.system(
        { "git", "-C", plugin.path, "rev-parse", "origin/HEAD" },
        { text = true },
        function(result)
          guarded_async(state, check_id, function()
            local rev_to = result.code == 0 and result.stdout:gsub("%s+$", "") or nil
            replace_plugin(state.plugins, name, store.with_rev_to(plugin, rev_to))
            maybe_finish()
          end)
        end
      )
    end
  end
end

---@param state Ui.State
M.local_check = function(state)
  async_call(function()
    local ok, plugins_or_err = pcall(vim.pack.get, nil, { offline = true })
    if not ok then
      state.status = tostring(plugins_or_err)
      M.emit_view(state)
      return
    end
    state.commits = {}
    state.plugins = force_plugins(plugins_or_err)
    state.status = "ready"
    M.emit_view(state)
    for _, plugin in ipairs(state.plugins) do
      if store.is_pending(plugin) then
        M.load_commits(state, plugin)
      end
    end
  end)
end

---@param state Ui.State
---@param names string[]
M.update = function(state, names)
  if #names == 0 then
    vim.notify("vim.pack: no pending updates", vim.log.levels.INFO)
    return
  end

  state.update_status = {}
  for _, name in ipairs(names) do
    state.update_status[name] = "queued" --[[@as string]]
  end
  state.status = "updating " .. table.concat(names, ", ")
  M.emit_view(state)

  async_call(function()
    -- 业务失败(pcall): 转 failed 状态, 不靠 safecall 吞
    local ok, err = pcall(vim.pack.update, names, { force = true, offline = true })
    if not ok then
      vim.notify("vim.pack: " .. tostring(err), vim.log.levels.ERROR)
      for _, name in ipairs(names) do
        if state.update_status[name] ~= "updated" then
          state.update_status[name] = "failed"
        end
      end
      state.status = "update failed"
      M.emit_view(state)
      return
    end
    for _, name in ipairs(names) do
      if state.update_status[name] ~= "updated" then
        state.update_status[name] = "failed"
      end
    end
    state.status = "updating " .. table.concat(names, ", ") .. " done"
    M.emit_view(state)
    M.local_check(state)
  end)
end

---@param state Ui.State
---@param name string
M.uninstall = function(state, name)
  if not vim.pack.del then
    vim.notify("vim.pack.del is unavailable", vim.log.levels.ERROR)
    return
  end

  local prompt = ("Uninstall %s from disk?\n"):format(name)
  local choice = vim.fn.confirm(prompt, "&Uninstall\n&Cancel", 2)
  if choice ~= 1 then
    return
  end

  state.check_id = state.check_id + 1
  state.checking = false
  state.status = "uninstalling " .. name
  M.emit_view(state)

  async_call(function()
    local ok, err = pcall(vim.pack.del, { name }, { force = true })
    if not ok then
      vim.notify("vim.pack: " .. tostring(err), vim.log.levels.ERROR)
      state.status = "uninstall failed"
      M.emit_view(state)
      return
    end
    state.commits[name] = nil
    state.expanded[name] = nil
    vim.notify(("vim.pack: uninstalled %s"):format(name), vim.log.levels.INFO)
    M.local_check(state)
  end)
end

---@param state Ui.State
---@param names string[]
M.clean = function(state, names)
  if #names == 0 then
    vim.notify("vim.pack: no not managed plugins", vim.log.levels.INFO)
    return
  end

  state.status = "cleaning " .. #names .. " plugins"
  M.emit_view(state)

  async_call(function()
    local ok, err = pcall(vim.pack.del, names, { force = true })
    if not ok then
      vim.notify("vim.pack: " .. tostring(err), vim.log.levels.ERROR)
      state.status = "clean failed"
      M.emit_view(state)
      return
    end
    vim.notify(("vim.pack: removed %d plugins"):format(#names), vim.log.levels.INFO)
    M.local_check(state)
  end)
end

---@param state Ui.State
---@param plugin Ui.Plugin
M.load_commits = function(state, plugin)
  local check_id = state.check_id
  state.commits[plugin.name] = nil
  M.emit_view(state)

  vim.system({
    "git",
    "-C",
    plugin.path,
    "log",
    "--pretty=format:%h %s (%cr)",
    "--abbrev-commit",
    "--date=short",
    "--color=never",
    "--no-show-signature",
    plugin.rev .. ".." .. plugin.rev_to,
  }, { text = true }, function(result)
    guarded_async(state, check_id, function()
      state.commits[plugin.name] = (
        result.code == 0 and store.parse_commits(split_lines(result.stdout)) or {}
      )
      M.emit_view(state)
    end)
  end)
end

---@param state Ui.State
M.emit_view = function(state)
  if M.on_view then
    M.on_view(state)
  end
end

return M
