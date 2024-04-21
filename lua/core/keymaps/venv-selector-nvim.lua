local M = {}
M.keys = {
	{
		"<leader>cv",
		"<Cmd>VenvSelect<CR>",
		desc = "Choose Python Venv",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
