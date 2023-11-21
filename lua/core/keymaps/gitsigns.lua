local M = {}
M.keys = {
	{
		"]c",
		"<Cmd>Gitsigns next_hunk<CR>",
		desc = "Git Hunk Next",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"[c",
		"<Cmd>Gitsigns prev_hunk<CR>",
		desc = "Git Hunk Previous",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
