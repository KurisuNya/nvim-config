local M = {}
M.config = function()
	local telescope = require("telescope")
	local undo_map = require("keymaps.plugins.telescope").telescope_undo

	telescope.setup({
		defaults = { vimgrep_arguments = KurisuNya.config.telescope_livegrep_args },
		pickers = { find_files = { find_command = KurisuNya.config.telescope_find_files_args } },
		extensions = {
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = { preview_height = 0.7 },
				mappings = { i = { [undo_map.restore] = require("telescope-undo.actions").restore } },
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})
	telescope.load_extension("undo")
	telescope.load_extension("fzf")
end
return M
