local M = {
	"folke/todo-comments.nvim",
	opts = {},
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
}
M.keys = function()
	if Utils.plugin_exists("trouble.nvim") then
		vim.keymap.set("n", "<leader>td", "<CMD>TodoTrouble toggle<CR>", {
			noremap = true,
			silent = true,
			desc = "List TODO",
		})
	else
		vim.keymap.set("n", "<leader>td", "<CMD>TodoQuickFix<CR>", {
			noremap = true,
			silent = true,
			desc = "List TODO",
		})
	end
end
return M
