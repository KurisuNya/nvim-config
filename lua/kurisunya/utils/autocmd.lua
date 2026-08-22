local M = {}

---@param name string
---@param clear? boolean
M.new_group = function(name, clear)
  return vim.api.nvim_create_augroup("kurisunya_utils_autocmd_" .. name, { clear = clear })
end

M.default_group = M.new_group("default", true)

return M
