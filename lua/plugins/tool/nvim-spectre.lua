local status, spectre = pcall(require, "spectre")
if not status then
	return
end
local map_list = require("core.keymaps.nvim-spectre")
spectre.setup({
	color_devicons = true,
	open_cmd = "vnew",
	live_update = false,
	line_sep_start = "┌------------------------------------------------------------------",
	result_padding = "¦  ",
	line_sep = "└------------------------------------------------------------------",
	highlight = {
		ui = "String",
		search = "DiffChange",
		replace = "DiffDelete",
	},
	mapping = map_list,
	find_engine = {
		["rg"] = {
			cmd = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			options = {
				["ignore-case"] = {
					value = "--ignore-case",
					icon = "[I]",
					desc = "ignore case",
				},
				["hidden"] = {
					value = "--hidden",
					desc = "hidden file",
					icon = "[H]",
				},
			},
		},
		["ag"] = {
			cmd = "ag",
			args = {
				"--vimgrep",
				"-s",
			},
			options = {
				["ignore-case"] = {
					value = "-i",
					icon = "[I]",
					desc = "ignore case",
				},
				["hidden"] = {
					value = "--hidden",
					desc = "hidden file",
					icon = "[H]",
				},
			},
		},
	},
	replace_engine = {
		["sed"] = {
			cmd = "sed",
			args = nil,
			options = {
				["ignore-case"] = {
					value = "--ignore-case",
					icon = "[I]",
					desc = "ignore case",
				},
			},
		},
		["oxi"] = {
			cmd = "oxi",
			args = {},
			options = {
				["ignore-case"] = {
					value = "i",
					icon = "[I]",
					desc = "ignore case",
				},
			},
		},
	},
	default = {
		find = {
			cmd = "rg",
			options = { "ignore-case" },
		},
		replace = {
			cmd = "sed",
		},
	},
	replace_vim_cmd = "cdo",
	is_open_target_win = true,
	is_insert_mode = false,
})
