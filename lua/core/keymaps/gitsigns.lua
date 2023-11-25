local M = {}
M.keys = {
	{
		"]h",
		"<Cmd>Gitsigns next_hunk<CR>",
		desc = "Next Git Hunk",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"[h",
		"<Cmd>Gitsigns prev_hunk<CR>",
		desc = "Previous Git Hunk",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
