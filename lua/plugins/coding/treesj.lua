local M = {
	"Wansmer/treesj",
	event = "VeryLazy",
}

M.keys = {
	{
		"<leader>k",
		function()
			require("treesj").toggle()
		end,
		desc = "Toggle Join/Split",
		mode = "n",
		silent = true,
	},
}

M.opts = {
	use_default_keymaps = false,
	max_join_length = 1000,
	notify = false,
}

return M
