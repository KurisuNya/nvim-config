local M = {}

---@param mode string|string[]
---@param key string|string[]
M.unset = function(mode, key)
  key = type(key) == "string" and { key } or key --[=[@as string[]]=]
  for _, k in ipairs(key) do
    vim.keymap.set(mode, k, "<Nop>")
  end
end

---@param mode string|string[]
---@param key string|string[]
M.del = function(mode, key)
  key = type(key) == "string" and { key } or key --[=[@as string[]]=]
  M.unset(mode, key)
  for _, k in ipairs(key) do
    vim.keymap.del(mode, k)
  end
end

---@param maps {[1]: string|string[], [2]: string, [3]: string|function, [4]: table|nil}[] list of {mode, key, action, opts}
---@param opts? table opts to override each map's opts
M.set_maps = function(maps, opts)
  for _, map in ipairs(maps) do
    if opts then
      map[4] = vim.tbl_extend("force", map[4] or {}, opts)
    end
    vim.keymap.set(map[1], map[2], map[3], map[4])
  end
end

---@param maps {[1]: string|string[], [2]: string, [3]: string|function, [4]: table|nil}[] list of {mode, key, action, opts}
M.del_maps = function(maps)
  for _, map in ipairs(maps) do
    M.del(map[1], map[2])
  end
end

return M
