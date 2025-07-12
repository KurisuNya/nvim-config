local M = { "stevearc/dressing.nvim" }
M.init = function()
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.select = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.input = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.input(...)
	end
end
M.config = function()
	local builtin = {
		show_numbers = true,
		border = Config.border_style,
		relative = "editor",

		buf_options = {},
		win_options = {
			cursorline = true,
			cursorlineopt = "both",
			winhighlight = "MatchParen:",
			statuscolumn = " ",
		},

		width = nil,
		max_width = { 140, 0.8 },
		min_width = { 40, 0.2 },
		height = nil,
		max_height = 0.9,
		min_height = { 10, 0.2 },

		mappings = {
			["<Esc>"] = "Close",
			["<C-c>"] = "Close",
			["<CR>"] = "Confirm",
		},

		override = function(conf)
			return conf
		end,
	}

	local borderchars = {
		rounded = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		single = {
			prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
		none = { " ", " ", " ", " ", " ", " ", " ", " " },
	}

	local opts = {
		input = { insert_only = false, border = Config.border_style },
		select = {
			backend = { "telescope", "builtin" },
			telescope = require("telescope.themes").get_dropdown({
				borderchars = borderchars[Config.border_style],
			}),
			builtin = builtin,
		},
	}
	require("dressing").setup(opts)
end
return M
