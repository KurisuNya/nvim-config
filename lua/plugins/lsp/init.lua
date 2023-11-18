-------------------
--  lsp-plugins  --
-------------------
return {

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.lsp.nvim-treesitter").config,
		dependenceies = {
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"andymass/vim-matchup",
		},
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	{ "windwp/nvim-ts-autotag" },
	{ "p00f/nvim-ts-rainbow", event = "VeryLazy" },
	{ "andymass/vim-matchup", event = "VeryLazy" },

	-- mason
	{ "williamboman/mason.nvim", opts = {}, event = "VeryLazy" },
	{
		"williamboman/mason-lspconfig.nvim",
		config = require("plugins.lsp.mason-lspconfig").config,
		event = "VeryLazy",
	},
	{
		"jayp0521/mason-null-ls.nvim",
		config = require("plugins.lsp.mason-null-ls").config,
		event = "VeryLazy",
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = require("plugins.lsp.mason-nvim-dap").config,
		event = "VeryLazy",
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		config = require("plugins.lsp.lspconfig").config,
		dependenceies = {
			"folke/neodev.nvim",
			"lvimuser/lsp-inlayhints.nvim",
			"hrsh7th/nvim-cmp",
		},
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-jdtls",
		config = require("plugins.lsp.nvim-jdtls").config,
		dependenceies = {
			"lvimuser/lsp-inlayhints.nvim",
			"hrsh7th/nvim-cmp",
		},
		ft = "java",
	},
	{
		"nvimtools/none-ls.nvim",
		config = require("plugins.lsp.null-ls").config,
		event = "VeryLazy",
	},
	{
		"glepnir/lspsaga.nvim",
		keys = require("core.keymaps.lspconfig").lspsaga_keys,
		config = require("plugins.lsp.lspsaga").config,
		event = "VeryLazy",
	},
	{
		"SmiteshP/nvim-navbuddy",
		keys = require("core.keymaps.lspconfig").nvim_navbuddy_keys,
		config = require("plugins.lsp.nvim-navbuddy").config,
		dependenceies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim", -- Optional
			"nvim-telescope/telescope.nvim", -- Optional
		},
		event = "VeryLazy",
	},
	{ "SmiteshP/nvim-navic", dependenceies = { "neovim/nvim-lspconfig" } },
	{ "folke/neodev.nvim", event = "VeryLazy" },
	{ "lvimuser/lsp-inlayhints.nvim", event = "VeryLazy" },
	{
		"folke/trouble.nvim",
		keys = require("core.keymaps.troubles").keys,
		event = "VeryLazy",
		opts = {},
	},

	-- dap
	{
		"rcarriga/nvim-dap-ui",
		keys = require("core.keymaps.nvim-dap-ui").keys,
		config = require("plugins.lsp.nvim-dap-ui").config,
		dependenceies = { "mfussenegger/nvim-dap" },
		event = "VeryLazy",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
		dependenceies = { "mfussenegger/nvim-dap" },
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-dap",
		keys = require("core.keymaps.nvim-dap").nvim_dap_keys,
		event = "VeryLazy",
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		keys = require("core.keymaps.nvim-dap").persistent_breakpoints_keys,
		event = "VeryLazy",
		opts = { load_breakpoints_event = { "BufReadPost" } },
	},
	{
		"ofirgall/goto-breakpoints.nvim",
		keys = require("core.keymaps.nvim-dap").goto_breakpoints_keys,
	},
}
