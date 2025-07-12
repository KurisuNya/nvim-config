local M = {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
}

M.keys = {
	{
		"]h",
		"<CMD>Gitsigns next_hunk<CR>",
		desc = "Next Git Hunk",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"[h",
		"<CMD>Gitsigns prev_hunk<CR>",
		desc = "Previous Git Hunk",
		mode = "n",
		noremap = true,
		silent = true,
	},
}

M.opts = {
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	current_line_blame = true,
	current_line_blame_formatter = "   <author_time:%Y-%m-%d>, <author> ∙ <summary>",
	preview_config = {
		border = Config.border_style,
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
}

return M
