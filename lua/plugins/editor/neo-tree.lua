M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VeryLazy",
}

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
}

PluginVars.neotree_hide_by_name = {}
PluginVars.neotree_always_show = { ".gitignore", ".gitattributes" }
PluginVars.neotree_hide_by_pattern = {}
PluginVars.neotree_never_show = {}
PluginVars.neotree_never_show_by_pattern = {}

M.init = function()
	PluginVars.insert(PluginVars.projections_close_filetypes, "neo-tree")
end

M.keys = {
	{
		"<leader>e",
		"<CMD>Neotree toggle dir=./<CR>",
		desc = "Neotree Toggle",
		mode = "n",
		noremap = true,
		silent = true,
	},
}

local mappings = {
	["<space>"] = "none",
	["l"] = "none",
	["t"] = "none",
	["w"] = "none",
	["C"] = "none",
	["z"] = "none",
	["zC"] = "close_all_nodes",
	["zO"] = "expand_all_nodes",
	["A"] = "none",
	["b"] = "none",
	["c"] = "none",
	["m"] = "none",
}
local filesystem_mappings = {
	["#"] = "none",
	["D"] = "none",
}

M.config = function()
	local opts = {
		close_if_last_window = true,
		popup_border_style = Config.border_style,
		default_component_configs = {
			modified = { symbol = Icons.git.Modified, highlight = "NeoTreeModified" },
			git_status = {
				symbols = {
					added = "",
					modified = "",
					unstaged = Icons.git.Unstaged,
					staged = Icons.git.Staged,
					conflict = Icons.git.Conflict,
					renamed = Icons.git.Renamed,
					untracked = Icons.git.Untracked,
					deleted = Icons.git.Deleted,
					ignored = Icons.git.Ignored,
				},
			},
		},
		window = { width = 35, mappings = mappings },
		filesystem = {
			filtered_items = {
				hide_dotfiles = true,
				hide_gitignored = false,
				hide_by_name = PluginVars.neotree_hide_by_name,
				hide_by_pattern = PluginVars.neotree_hide_by_pattern,
				always_show = PluginVars.neotree_always_show,
				never_show = PluginVars.neotree_never_show,
				never_show_by_pattern = PluginVars.neotree_never_show_by_pattern,
			},
			follow_current_file = { enabled = true, leave_dirs_open = false },
			use_libuv_file_watcher = true,
			window = { mappings = filesystem_mappings },
		},
	}

	local events = require("neo-tree.events")
	local function close_tree()
		require("neo-tree.command").execute({ action = "close" })
	end
	opts.event_handlers = { { event = events.FILE_OPENED, handler = close_tree } }

	if Utils.plugin_exists("snacks.nvim") then
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
