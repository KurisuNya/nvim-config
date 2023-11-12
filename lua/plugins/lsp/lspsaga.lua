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
