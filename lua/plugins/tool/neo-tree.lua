local neo_tree_status, neo_tree = pcall(require, "neo-tree")
if not neo_tree_status then
	return
end

local lsp_ui = require("plugins.ui.lsp-ui")
vim.fn.sign_define("DiagnosticSignError", {
	text = lsp_ui.diagnostics.icons.error,
	texthl = "DiagnosticSignError",
})
vim.fn.sign_define("DiagnosticSignWarn", {
	text = lsp_ui.diagnostics.icons.warning,
	texthl = "DiagnosticSignWarn",
})
vim.fn.sign_define("DiagnosticSignInfo", {
	text = lsp_ui.diagnostics.icons.info,
	texthl = "DiagnosticSignInfo",
})
vim.fn.sign_define("DiagnosticSignHint", {
	text = lsp_ui.diagnostics.icons.hint,
	texthl = "DiagnosticSignHint",
})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
neo_tree.setup({
	close_if_last_window = true,
	popup_border_style = "rounded",

	default_component_configs = {
		modified = {
			symbol = "",
			highlight = "NeoTreeModified",
		},
		git_status = {
			symbols = {
				added = "",
				modified = "",
				unstaged = "",
				staged = "",
				conflict = "שׂ",
				renamed = "",
				untracked = "ﲉ",
				deleted = "",
				ignored = "",
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
