-- import telescope plugin safely
local status, telescope = pcall(require, "telescope")
if not status then
	return
end

-- configure telescope
local map_list = require("core.keymaps.telescope-undo")

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
				"rg",
				"--files",
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
	},
	extensions = {
		undo = {
			use_delta = true,
			side_by_side = false,
			use_custom_command = nil,
			diff_context_lines = vim.o.scrolloff,
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
telescope.load_extension("frecency")
telescope.load_extension("projects")
