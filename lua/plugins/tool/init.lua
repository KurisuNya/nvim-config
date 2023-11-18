--------------------
--  tool-plugins  --
--------------------
return {

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
			},
			last_session_on_startup = false,
		},
		dependenceies = {
			"nvim-lua/plenary.nvim",
			"Shatur/neovim-session-manager",
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
	},
	{ "Shatur/neovim-session-manager" },

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = require("core.keymaps.telescope").keys,
		config = require("plugins.tool.telescope").config,
		dependenceies = {
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
		event = "VeryLazy",
	},
	{ "debugloop/telescope-undo.nvim", event = "VeryLazy" },
	{ "nvim-telescope/telescope-frecency.nvim", event = "VeryLazy" },

	-- git
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
		},
		event = "VeryLazy",
	},
	{
		"KurisuNya/vgit.nvim",
		keys = require("core.keymaps.vgit").keys,
		opts = {},
		event = "VeryLazy",
	},

	-- operations
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
		event = "BufRead",
	},
	{
		"Weissle/easy-action",
		keys = require("core.keymaps.easy-action").keys,
		opts = {
			jump_provider = "leap",
			jump_provider_config = {
				leap = {
					action_select = {
						default = function()
							require("leap").leap({ target_windows = { vim.fn.win_getid() } })
						end,
					},
				},
			},
		},
		event = "VeryLazy",
	},
	{
		"nguyenvukhang/nvim-toggler",
		keys = require("core.keymaps.nvim-toggler").keys,
		config = require("plugins.tool.nvim-toggler").config,
		event = "VeryLazy",
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
			vim.g.table_mode_map_prefix = "<Bar>"
			vim.g.table_mode_toggle_map = "<Bar>"
			vim.g.table_mode_tableize_map = "<leader><Bar>"
			vim.g.table_mode_corner = "|"
		end,
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

	-- linux
	{ "h-hg/fcitx.nvim", event = "VeryLazy" },
	{
		"lambdalisue/suda.vim",
		init = function()
			vim.g.suda_smart_edit = 1
		end,
		event = "VeryLazy",
	},

	-- other
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
