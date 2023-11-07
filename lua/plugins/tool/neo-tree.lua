local status, neo_tree = pcall(require, "neo-tree")
if not status then
	return
end

local icons = require("plugins.ui.icons")
vim.fn.sign_define("DiagnosticSignError", {
	text = icons.diagnostics.Error,
	texthl = "DiagnosticSignError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
	text = icons.diagnostics.Warning,
	texthl = "DiagnosticSignWarn",
})
vim.fn.sign_define("DiagnosticSignInfo", {
	text = icons.diagnostics.Info,
	texthl = "DiagnosticSignInfo",
})
vim.fn.sign_define("DiagnosticSignHint", {
	text = icons.diagnostics.Hint,
	texthl = "DiagnosticSignHint",
})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
neo_tree.setup({
	close_if_last_window = true,
	popup_border_style = "rounded",

	default_component_configs = {
		modified = {
			symbol = icons.git.Modified,
			highlight = "NeoTreeModified",
		},
		git_status = {
			symbols = {
				added = "",
				modified = "",
				unstaged = icons.git.Unstaged,
				staged = icons.git.Staged,
				conflict = icons.git.Conflict,
				renamed = icons.git.Renamed,
				untracked = icons.git.Untracked,
				deleted = icons.git.Deleted,
				ignored = icons.git.Ignored,
			},
		},
	},

	window = {
		width = 35,
		mappings = {
			["<space>"] = "none",
			["t"] = "none",
		},
	},

	filesystem = {
		filtered_items = {
			hide_dotfiles = true,
			hide_gitignored = false,
			hide_by_name = {
				"node_modules",
			},
			hide_by_pattern = {},
			always_show = {
				".gitignored",
			},
			never_show = {},
			never_show_by_pattern = {},
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		use_libuv_file_watcher = true,
	},

	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
})
