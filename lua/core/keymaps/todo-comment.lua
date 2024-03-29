local M = {}
M.keys = function()
	if require("lazy.core.config").spec.plugins["trouble.nvim"] ~= nil then
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
