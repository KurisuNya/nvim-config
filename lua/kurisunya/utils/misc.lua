local M = {}

---@param tbl table table to set value in
---@param value any value to set
---@param ... any Optional keys (0 or more, variadic) via which to index the table
M.tbl_set = function(tbl, value, ...)
  vim.validate("tbl", tbl, "table")
  local keys = { ... }
  if #keys == 0 then
    error("expected at least one key")
  end

  local parent = tbl
  for i = 1, #keys - 1 do
    local k = keys[i]
    local next = parent[k]
    if next == nil then
      next = {}
      parent[k] = next
    elseif type(next) ~= "table" then
      error(("tbl_set: cannot set through non-table value at key %q"):format(tostring(k)))
    end
    parent = next
  end
  parent[keys[#keys]] = value
end

---@generic V
---@param list V[]
---@return V[]
M.list_filter_same = function(list)
  local seen = {}
  local result = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      seen[v] = true
      table.insert(result, v)
    end
  end
  return result
end

---@generic V
---@param list V[]
---@param item V
---@param key? fun(item: V): any
M.list_insert_sorted = function(list, item, key)
  local idx = vim.list.bisect(list, item, { key = key, bound = "upper" })
  table.insert(list, idx, item)
end

---@generic V
---@param list V[]
---@param key? fun(item: V): any
M.list_sort_stable = function(list, key)
  key = key or function(x) return x end
  local n = #list
  local decorated = {}
  for i = 1, n do
    local v = list[i]
    decorated[i] = { v = v, k = key(v), i = i }
  end
  table.sort(decorated, function(a, b)
    if a.k == b.k then
      return a.i < b.i
    end
    return a.k < b.k
  end)
  for i = 1, n do
    list[i] = decorated[i].v
  end
end

return M
