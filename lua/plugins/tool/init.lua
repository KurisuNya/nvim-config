--------------------
--  tool-plugins  --
--------------------
local M = {

	-- dashboard and explorer
	{
		"goolord/alpha-nvim",
		config = require("plugins.tool.alpha-nvim").config,
		lazy = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = require("core.keymaps.neo-tree").keys,
		config = require("plugins.tool.neo-tree").config,
		branch = "v3.x",
		event = "VeryLazy",
	},

	-- session
	{
		"coffebar/neovim-project",
		init = function()
			vim.opt.sessionoptions:append("globals")
		end,
		opts = {
			projects = { -- define project roots
				"~/Documents/Projects/*",
				"~/Documents/PlatformIO/Projects/*",
				"~/.config/*",
				"~/.local/share/nvim/lazy/*",
			},
			last_session_on_startup = false,
		},
		dependencies = {
			"Shatur/neovim-session-manager",
		},
		event = "VeryLazy",
	},
	{ "Shatur/neovim-session-manager" },

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = require("core.keymaps.telescope").keys,
		config = require("plugins.tool.telescope").config,
		dependencies = {
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-frecency.nvim",
		},
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
			.. "cmake --build build --config Release && "
			.. "cmake --install build --prefix build",
	},
	{ "debugloop/telescope-undo.nvim" },
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
		},
	},
	{ "kkharji/sqlite.lua" },

	-- git
	{
		"lewis6991/gitsigns.nvim",
		keys = require("core.keymaps.gitsigns").keys,
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			current_line_blame = true,
			current_line_blame_formatter = "   <author_time:%Y-%m-%d>, <author> ∙ <summary>",
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		event = "VeryLazy",
	},
	{
		"rhysd/git-messenger.vim",
		keys = require("core.keymaps.git-messenger").keys,
		init = function()
			vim.g.git_messenger_no_default_mappings = true
		end,
		config = require("plugins.tool.git-messenger").config,
		event = "VeryLazy",
	},
	{
		"chrisgrieser/nvim-tinygit",
		keys = require("core.keymaps.nvim-tinygit").keys,
		ft = { "gitrebase", "gitcommit" },
	},
	{
		"sindrets/diffview.nvim",
		keys = require("core.keymaps.diffview").keys,
		config = require("plugins.tool.diffview").config,
		event = "VeryLazy",
	},

	-- operations
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings(true)
		end,
		event = "VeryLazy",
	},
	{
		"ggandor/leap-spooky.nvim",
		opts = {},
		dependencies = {
			"ggandor/leap.nvim",
		},
		event = "VeryLazy",
	},
	{
		"nguyenvukhang/nvim-toggler",
		keys = require("core.keymaps.nvim-toggler").keys,
		config = require("plugins.tool.nvim-toggler").config,
		event = "VeryLazy",
	},
	{ "Darazaki/indent-o-matic", event = "BufRead", opts = {} },
	{ "numToStr/Comment.nvim", opts = {}, event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{
		"bkad/CamelCaseMotion",
		keys = require("core.keymaps.camelcase").keys,
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		keys = require("core.keymaps.todo-comment").keys,
		opts = {},
		event = "VeryLazy",
	},
	{
		"chentoast/marks.nvim",
		keys = require("core.keymaps.marks").keys,
		opts = {
			default_mappings = false,
			force_write_shada = true,
		},
		event = "VeryLazy",
	},

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		keys = require("core.keymaps.markdown-preview").keys,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
	{
		"KurisuNya/nvim-picgo",
		keys = require("core.keymaps.nvim-picgo").keys,
		opts = {},
		ft = "markdown",
	},
	{
		"dhruvasagar/vim-table-mode",
		keys = {
			{
				"<leader>|",
				desc = "Tableize",
				mode = "n",
			},
		},
		init = function()
			vim.g.table_mode_kap_prefix = "<Bar>"
			vim.g.table_mode_toggle_map = "<Bar>"
			vim.g.table_mode_tableize_map = "<leader><Bar>"
			vim.g.table_mode_corner = "|"
		end,
		ft = "markdown",
	},

	-- other
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = require("core.keymaps.toggleterm").keys,
		config = require("plugins.tool.toggleterm").config,
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 1000
		end,
		opts = {},
		event = "VeryLazy",
	},
	{
		"nvim-pack/nvim-spectre",
		keys = require("core.keymaps.nvim-spectre").keys,
		config = require("plugins.tool.nvim-spectre").config,
		event = "VeryLazy",
	},
	{
		"ziontee113/icon-picker.nvim",
		keys = require("core.keymaps.icon-picker").keys,
		opts = {
			disable_legacy_commands = true,
		},
		event = "VeryLazy",
	},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		opts = {
			display = {
				"TempFloatingWindow", --# display results in a floating window
			},
			borders = "rounded",
		},
		event = "VeryLazy",
	},
}

if vim.loop.os_uname().sysname == "Linux" then
	local linux_plugins = {
		-- linux
		{ "h-hg/fcitx.nvim", event = "VeryLazy" },
		{
			"lambdalisue/suda.vim",
			init = function()
				vim.g.suda_smart_edit = 1
			end,
			event = "VeryLazy",
		},
	}
	for _, plugin in ipairs(linux_plugins) do
		table.insert(M, plugin)
	end
end
return M
