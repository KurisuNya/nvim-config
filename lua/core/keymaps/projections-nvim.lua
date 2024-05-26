local M = {}
M.keys = {
	{
		"<leader>fp",
		"<Cmd>Telescope projections<CR>",
		desc = "find project",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
