local M = {
	"dhruvasagar/vim-table-mode",
	ft = "markdown",
}
M.init = function()
	vim.g.table_mode_map_prefix = "<Bar>"
	vim.g.table_mode_toggle_map = "<Bar>"
	vim.g.table_mode_tableize_map = "<leader><Bar>"
	vim.g.table_mode_corner = "|"
end
return M
