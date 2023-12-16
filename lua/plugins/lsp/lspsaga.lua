local M = {}
local icons = require("plugins.ui.icons")
M.config = function()
	local map_list = require("core.keymaps.lspconfig")
	require("lspsaga").setup({
		rename = {
			in_select = false,
			auto_save = true,
		},
		symbol_in_winbar = {
			enable = false,
		},
		finder = {
			keys = map_list.lspsaga_finder_keymap,
		},
		outline = {
			layout = "float",
			keys = map_list.lspsaga_outline_keymap,
		},
		ui = {
			expand = icons.ui.ArrowClose,
			collapse = icons.ui.ArrowOpen,
			lines = { "└", "├", "│", "─", "┌" },
		},
	})
end
return M
