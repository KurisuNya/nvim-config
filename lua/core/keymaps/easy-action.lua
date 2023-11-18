local M = {}
M.keys = {
	{
		"<leader><leader>a",
		"<Cmd>BasicEasyAction<CR>",
		desc = "Action Everywhere",
		mode = { "n", "x" },
		noremap = true,
		silent = true,
	},
}
return M
