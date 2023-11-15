local status, lspsaga = pcall(require, "lspsaga")
if not status then
	return
end

local map_list = require("core.keymaps.lspconfig")
lspsaga.setup({
	rename = {
		in_select = false,
		auto_save = true,
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		ignore_patterns = nil,
		show_file = true,
		folder_level = 1,
		color_mode = true,
		dely = 300,
	},
	finder = {
		keys = map_list.finder_keymap,
	},
	outline = {
		layout = "float",
		keys = map_list.outline_keymap,
	},
	ui = {
		lines = { "└", "├", "│", "─", "┌" },
	},
})
