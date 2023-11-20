local M = {}
M.keys = {
	{
		"L",
		"<Cmd>Gitsigns preview_hunk<CR>",
		desc = "Git Hunk Preview",
		mode = "n",
		noremap = true,
		silent = true,
	},
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
