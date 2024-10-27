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
	{
		"<leader>cV",
		function()
			require("venv-selector").deactivate()
			vim.notify("Deactivated Python Venv")
		end,
		desc = "Deactivate Python Venv",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
