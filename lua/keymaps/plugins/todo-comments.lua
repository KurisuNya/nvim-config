local M = {}
M.keys = function()
	if KurisuNya.utils.plugin_exist("trouble.nvim") then
		vim.keymap.set("n", "<leader>td", "<Cmd>TodoTrouble toggle<CR>", {
			noremap = true,
			silent = true,
			desc = "List TODO",
		})
	else
		vim.keymap.set("n", "<leader>td", "<Cmd>TodoLocList<CR>", {
			noremap = true,
			silent = true,
			desc = "List TODO",
		})
	end
end
return M
