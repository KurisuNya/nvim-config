local M = {
	"linux-cultist/venv-selector.nvim",
	ft = "python",
}

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

M.config = function()
	local opts = { settings = { search = {} } }
	if not Utils.is_windows() then
		opts.settings.search.pyenv = {
			command = "$FD '/bin/python$' ~/.pyenv --full-path --color never -L -E /proc -E envs",
		}
	end
	require("venv-selector").setup(opts)
end

return M
