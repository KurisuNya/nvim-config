local M = {}
M.config = function()
	local custom = require("plugins.editor.diffview-custom")
	local view_map_list = require("keymaps.plugins.diffview").view_keymap_list()
	local file_panel_map_list = require("keymaps.plugins.diffview").file_panel_keymap_list()
	local file_history_panel_map_list = require("keymaps.plugins.diffview").file_history_panel_keymap_list()
	local diff3_map_list = require("keymaps.plugins.diffview").diff3_keymap_list()
	local help_panel_map_list = require("keymaps.plugins.diffview").help_panel_keymap_list()
	local option_panel_map_list = require("keymaps.plugins.diffview").option_panel_keymap_list()

	require("diffview").setup({
		enhanced_diff_hl = true,
		show_help_hints = false,
		file_panel = {
			listing_style = "list",
			win_config = {
				position = "bottom",
				height = 10,
			},
		},
		keymaps = {
			disable_defaults = true,
			view = view_map_list,
			file_panel = file_panel_map_list,
			file_history_panel = file_history_panel_map_list,
			diff3 = diff3_map_list,
			help_panel = help_panel_map_list,
			option_panel = option_panel_map_list,
		},
		hooks = {
			diff_buf_read = custom.diffview_buffer_read_hunk,
			view_opened = custom.diffview_view_opened_hunk,
			view_closed = custom.diffview_view_close_hunk,
		},
	})
end
return M
