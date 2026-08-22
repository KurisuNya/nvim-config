local M = {}

---@param group string
M.get_color = function(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  local fg = hl.fg and string.format("#%06x", hl.fg) or nil
  local bg = hl.bg and string.format("#%06x", hl.bg) or nil
  return { fg = fg, bg = bg }
end

return M
