local M = {}
M.config = function()
	local icons = require("plugins.ui.icons")
	local mappings = require("keymaps.plugins.neo-tree").get_mappings()

	vim.g.neo_tree_remove_legacy_commands = 1
	local opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",

		default_component_configs = {
			modified = { symbol = icons.git.Modified, highlight = "NeoTreeModified" },
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

		window = { width = 35, mappings = mappings },

		filesystem = {
			filtered_items = {
				hide_dotfiles = true,
				hide_gitignored = false,
				hide_by_name = { "node_modules", "__pycache__" },
				hide_by_pattern = {},
				always_show = { ".gitignore" },
				never_show = {},
				never_show_by_pattern = {},
			},
			follow_current_file = { enabled = true, leave_dirs_open = false },
			use_libuv_file_watcher = true,
		},
	}

	local events = require("neo-tree.events")
	local function close_tree()
		require("neo-tree.command").execute({ action = "close" })
	end
	opts.event_handlers = { { event = events.FILE_OPENED, handler = close_tree } }

	if KurisuNya.utils.plugin_exist("snacks.nvim") then
		local function on_move(data)
			Snacks.rename.on_rename_file(data.source, data.destination)
		end
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
	end

	require("neo-tree").setup(opts)
end
return M
