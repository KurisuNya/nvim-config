local M = {}
M.keys = {
	{
		"<leader>ft",
		"<Cmd>ToggleTerm direction=float<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Float Terminal",
	},
	{
		"<leader>vt",
		"<Cmd>ToggleTerm direction=vertical<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Vertical Terminal",
	},
	{
		"<leader>ht",
		"<Cmd>ToggleTerm direction=horizontal<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Horizontal Terminal",
	},
}
M.toggle_everywhere = [[<C-\>]]
return M
