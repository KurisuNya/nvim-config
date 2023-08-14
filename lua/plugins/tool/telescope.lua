-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local map_list = require("core.keymaps").telescope_undo
-- configure telescope
telescope.setup({
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
