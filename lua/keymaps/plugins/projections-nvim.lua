local M = {}
M.keys = function()
	if KurisuNya.utils.plugin_exist("telescope.nvim") then
		vim.keymap.set(
			"n",
			"<leader>fp",
			"<Cmd>Telescope projections<CR>",
			{ desc = "find project", noremap = true, silent = true }
		)
	end
end
return M
