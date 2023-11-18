local M = {}
M.keys = {
	{
		"<leader>x",
		"<Cmd>TroubleToggle<CR>",
		desc = "Trouble View Toggle",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
