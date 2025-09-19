local custom = require("plugins.editor.diffview.custom")
local keymaps = require("plugins.editor.diffview.keymaps")

local M = {
	"sindrets/diffview.nvim",
	dependencies = { "lewis6991/gitsigns.nvim" },
	event = "VeryLazy",
}

M.init = function()
	PluginVars.insert(PluginVars.projections_close_filetypes, "DiffviewFiles")
	PluginVars.insert(PluginVars.projections_close_filetypes, "DiffviewFileHistory")
end

M.keys = keymaps.keys

M.config = function()
	require("diffview").setup({
		enhanced_diff_hl = true,
		show_help_hints = false,
		file_panel = {
			listing_style = "list",
			win_config = { position = "bottom", height = 10 },
		},
		keymaps = {
			disable_defaults = true,
			view = keymaps.view_keymap_list(),
			file_panel = keymaps.file_panel_keymap_list(),
			file_history_panel = keymaps.file_history_panel_keymap_list(),
			help_panel = keymaps.help_panel_keymap_list(),
			option_panel = keymaps.option_panel_keymap_list(),
		},
		hooks = {
			diff_buf_read = custom.diffview_buffer_read_hook,
			view_opened = custom.diffview_view_opened_hook,
			view_closed = custom.diffview_view_close_hook,
		},
	})
end
return M
