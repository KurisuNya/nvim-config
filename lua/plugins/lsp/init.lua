-------------------
--  lsp-plugins  --
-------------------
return {

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.lsp.nvim-treesitter").config,
		dependencies = {
			"andymass/vim-matchup",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "windwp/nvim-ts-autotag" },
	{ "andymass/vim-matchup" },

	-- mason
	{ "williamboman/mason.nvim", opts = {}, event = "VeryLazy" },
	{
		"williamboman/mason-lspconfig.nvim",
		config = require("plugins.lsp.mason-lspconfig").config,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		config = require("plugins.lsp.mason-null-ls").config,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = require("plugins.lsp.mason-nvim-dap").config,
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		config = require("plugins.lsp.lspconfig").config,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-jdtls",
		config = require("plugins.lsp.nvim-jdtls").config,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		ft = "java",
	},
	{
		"nvimtools/none-ls.nvim",
		config = require("plugins.lsp.null-ls").config,
		dependencies = {
			"williamboman/mason.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		event = "VeryLazy",
	},
	{ "davidmh/cspell.nvim" },
	{
		"nvimdev/lspsaga.nvim",
		config = require("plugins.lsp.lspsaga").config,
		event = "VeryLazy",
	},
	{
		"KurisuNya/nvim-gtd",
		config = require("plugins.lsp.gtd").config,
		event = "VeryLazy",
	},
	{
		"SmiteshP/nvim-navbuddy",
		config = require("plugins.lsp.nvim-navbuddy").config,
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim",
		keys = require("core.keymaps.trouble").keys,
		opts = {},
		event = "VeryLazy",
	},
	{
		"linux-cultist/venv-selector.nvim",
		config = require("plugins.lsp.venv-selector-nvim").config,
		event = "VeryLazy",
	},
	{ "SmiteshP/nvim-navic" },
	{ "folke/neodev.nvim" },
	{ "lvimuser/lsp-inlayhints.nvim" },

	-- dap
	{
		"rcarriga/nvim-dap-ui",
		keys = require("core.keymaps.nvim-dap-ui").keys,
		config = require("plugins.lsp.nvim-dap-ui").config,
		event = "VeryLazy",
	},
	{ "theHamsta/nvim-dap-virtual-text", opts = {}, event = "VeryLazy" },
	{
		"mfussenegger/nvim-dap",
		keys = require("core.keymaps.nvim-dap").nvim_dap_keys,
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-dap-python",
		config = require("plugins.lsp.nvim-dap-python").config,
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
