-- import telescope plugin safely
local M = {}
M.config = function()
	local telescope = require("telescope")
	local map_list = require("core.keymaps.telescope").telescope_undo

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
				"--glob",
				"!Webdav/",
				"--glob",
				"!Remote/",
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
					"Webdav/",
					"-E",
					"Remote/",
					"-E",
					"**/.git/*",
					"-E",
					"**/node_modules/*",
				},
			},
		},
		extensions = {
			undo = {
				use_delta = true,
				side_by_side = false,
				use_custom_command = nil,
				vim_diff_opts = { ctxlen = 8 },
				entry_format = "state #$ID, $STAT, $TIME",
				mappings = {
					i = {
						[map_list.restore] = require("telescope-undo.actions").restore,
					},
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
