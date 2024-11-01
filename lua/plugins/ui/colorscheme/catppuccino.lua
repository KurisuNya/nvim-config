---@diagnostic disable: missing-fields
local M = {}
M.config = function(name)
	vim.cmd.colorscheme(name)
end
return M
