local M = {}
M.config = function()
	local telescope = require("telescope")
	local undo_map = require("keymaps.plugins.telescope").telescope_undo

	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
				"--hidden",
				"--glob",
				"!**/.git/*",
				"--glob",
				"!**/node_modules/*",
			},
		},
		pickers = {
			find_files = {
				find_command = {
					"fd",
					"--type",
					"file",
					"--hidden",
					"-E",
					"**/.git/*",
					"-E",
					"**/node_modules/*",
				},
			},
		},
		extensions = {
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = { preview_height = 0.7 },
				mappings = {
					i = { [undo_map.restore] = require("telescope-undo.actions").restore },
				},
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
