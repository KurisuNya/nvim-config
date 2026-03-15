local M = {
	"linux-cultist/venv-selector.nvim",
	opts = {},
	ft = "python",
}

M.keys = {
	{
		"<leader>cv",
		"<Cmd>VenvSelect<CR>",
		desc = "Python Venv Choose",
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
		desc = "Python Venv Deactivate",
		mode = "n",
		noremap = true,
		silent = true,
	},
}

return M
