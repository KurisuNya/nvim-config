local M = {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
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

	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		map("n", "]h", gs.next_hunk, "Next Git Hunk")
		map("n", "[h", gs.prev_hunk, "Previous Git Hunk")
	end,
}

return M
