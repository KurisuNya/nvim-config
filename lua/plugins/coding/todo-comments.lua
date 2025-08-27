local M = {
	"folke/todo-comments.nvim",
	opts = {},
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
}
M.keys = {
	{
		"<leader>td",
		"<CMD>TodoQuickFix<CR>",
		desc = "List TODO",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
