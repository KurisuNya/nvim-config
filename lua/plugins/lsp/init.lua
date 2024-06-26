-------------------
--  lsp-plugins  --
-------------------
local M = {

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.lsp.nvim-treesitter").config,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "windwp/nvim-ts-autotag" },

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
			{
				"folke/neoconf.nvim",
				cmd = "Neoconf",
				config = false,
				dependencies = { "nvim-lspconfig" },
			},
			{ "folke/neodev.nvim", opts = {} },
		},
		event = "VeryLazy",
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		config = function()
			require("inlay-hints").setup()
		end,
	},
	{
		"felpafel/inlay-hint.nvim",
		event = "LspAttach",
		config = function()
			require("inlay-hint").setup()
		end,
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
		branch = "regexp",
		config = require("plugins.lsp.venv-selector-nvim").config,
		keys = require("core.keymaps.venv-selector-nvim").keys,
		event = "VeryLazy",
	},
	{ "SmiteshP/nvim-navic" },

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
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-python",
			"rcasia/neotest-java",
		},
		keys = require("core.keymaps.neotest").keys,
		config = require("plugins.lsp.neotest").config,
		event = "VeryLazy",
	},
}
if vim.loop.os_uname().sysname ~= "Windows_NT" then
	local plugins = {
		{ "davidmh/cspell.nvim" },
	}
	for _, plugin in ipairs(plugins) do
		table.insert(M, plugin)
	end
end
return M
