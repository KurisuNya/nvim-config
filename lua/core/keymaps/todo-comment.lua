local M = {}
M.keys = function()
	vim.keymap.set("n", "<leader>z", "<Cmd>TroubleToggle todo<CR>", {
		noremap = true,
		silent = true,
		desc = "List TODO",
	})
	vim.keymap.set("n", "<leader>ft", "<Cmd>TodoTelescope<CR>", {
		noremap = true,
		silent = true,
		desc = "Find TODO",
	})
end
return M
