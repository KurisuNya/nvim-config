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
	{
		"<leader>1",
		"<Cmd>ToggleTerm 1<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 1",
	},
	{
		"<leader>2",
		"<Cmd>ToggleTerm 2<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 2",
	},
	{
		"<leader>3",
		"<Cmd>ToggleTerm 3<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 3",
	},
	{
		"<leader>4",
		"<Cmd>ToggleTerm 4<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 4",
	},
}
M.toggle_everywhere = [[<C-\>]]
return M
