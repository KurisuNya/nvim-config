return {
	----------------
	-- dependence --
	----------------
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "kkharji/sqlite.lua", event = "VeryLazy" },
	{ "kevinhwang91/promise-async", event = "VeryLazy" },
	{ "SmiteshP/nvim-navic", event = "VeryLazy" },

	--------
	-- ui --
	--------
	-- theme
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	-- utils
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {
			color_icons = true,
			default = true,
			strict = true,
		},
	},
	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	-- bar and line
	{ "romgrk/barbar.nvim", event = "VeryLazy" },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	-- notify
	{ "KurisuNya/noice.nvim", event = "VeryLazy" },
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			render = "wrapped-compact",
			stages = "static",
			timeout = 4000,
		},
	},
	-- better ui
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{
		"machakann/vim-highlightedyank",
		event = "VeryLazy",
		init = function()
			vim.g.highlightedyank_highlight_duration = 400
			vim.b.highlightedyank_highlight_duration = 400
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		init = function()
			vim.opt.termguicolors = true
		end,
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{ "kevinhwang91/nvim-ufo", event = "VeryLazy" },
	{
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		opts = {},
	},

	---------
	-- cmp --
	---------
	{ "abecodes/tabout.nvim", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", event = "VeryLazy" },
	-- snip
	{ "L3MON4D3/LuaSnip", event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets", event = "VeryLazy" },
	{ "KurisuNya/cheeky-snippets.nvim", event = "VeryLazy" },
	{ "ziontee113/SnippetGenie", event = "VeryLazy" },
	-- cmp
	{ "hrsh7th/nvim-cmp", event = "VeryLazy" },
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },
	{ "FelipeLema/cmp-async-path", event = "VeryLazy" },
	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "kdheepak/cmp-latex-symbols", event = "VeryLazy" },
	{ "lukas-reineke/cmp-under-comparator", event = "VeryLazy" },

	---------
	-- lsp --
	---------
	-- treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "VeryLazy" },
	{ "p00f/nvim-ts-rainbow", event = "VeryLazy" },
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	-- mason
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
	{ "jayp0521/mason-null-ls.nvim", event = "VeryLazy" },
	{ "jay-babu/mason-nvim-dap.nvim", event = "VeryLazy" },
	-- lsp
	{ "neovim/nvim-lspconfig", event = "VeryLazy" },
	{ "glepnir/lspsaga.nvim", event = "VeryLazy" },
	{ "lvimuser/lsp-inlayhints.nvim", event = "VeryLazy" },
	{ "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },
	{ "folke/neodev.nvim", event = "VeryLazy" },
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{ "SmiteshP/nvim-navbuddy", event = "VeryLazy" },
	-- dap
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{ "ofirgall/goto-breakpoints.nvim", event = "VeryLazy" },

	----------
	-- tool --
	----------
	-- dashboard and explorer
	{ "goolord/alpha-nvim", event = "VeryLazy" },
	{ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", event = "VeryLazy" },
	-- session
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		init = function()
			require("project_nvim").setup({
				manual_mode = true,
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},

	-- git
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{ "lewis6991/gitsigns.nvim", event = "VeryLazy" },
	-- telescope
	{ "nvim-telescope/telescope.nvim", event = "VeryLazy" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		event = "VeryLazy",
	},
	{ "debugloop/telescope-undo.nvim", event = "VeryLazy" },
	{ "nvim-telescope/telescope-frecency.nvim", event = "VeryLazy" },
	-- operations
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nguyenvukhang/nvim-toggler",
		event = "VeryLazy",
		opts = {
			remove_default_keybinds = true,
		},
	},
	{ "tpope/vim-surround", event = "VeryLazy" },
	{
		"phaazon/hop.nvim",
		event = "VeryLazy",
		opts = {},
		branch = "v2",
	},
	{ "bkad/CamelCaseMotion", event = "VeryLazy" },
	{
		"dhruvasagar/vim-table-mode",
		event = "VeryLazy",
		init = function()
			vim.g.table_mode_map_prefix = "<Bar>"
			vim.g.table_mode_toggle_map = "<Bar>"
			vim.g.table_mode_tableize_map = "<leader><Bar>"
			vim.g.table_mode_corner = "|"
		end,
	},
	{ "andymass/vim-matchup", event = "VeryLazy" },
	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"KurisuNya/nvim-picgo",
		event = "VeryLazy",
		opts = {},
	},
	-- linux
	{ "h-hg/fcitx.nvim", event = "VeryLazy" },
	{
		"lambdalisue/suda.vim",
		event = "VeryLazy",
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	-- other
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 1000
		end,
		opts = {},
	},
	{ "nvim-pack/nvim-spectre", event = "VeryLazy" },
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		event = "VeryLazy",
		opts = {
			display = {
				"TempFloatingWindow", --# display results in a floating window
			},
			borders = "rounded",
		},
	},
}
