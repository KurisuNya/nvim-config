local M = {}
M.keys = {
	{
		"<leader>|",
		desc = "Tableize",
		mode = "n",
	},
}
M.table_mode_map_prefix = "<Bar>"
M.table_mode_toggle_map = "<Bar>"
M.table_mode_tableize_map = "<leader><Bar>"
M.table_mode_corner = "|"
return M
