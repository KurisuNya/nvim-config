------------------
--  ui-plugins  --
------------------
return {

	-- bars and lines
	{
		"romgrk/barbar.nvim",
		config = require("plugins.ui.barbar").config,
		keys = require("core.keymaps.barbar").keys,
		lazy = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = require("plugins.ui.lualine").config,
		dependencies = {
			"KurisuNya/noice.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
	},

	-- notify
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "wrapped-compact",
			stages = "static",
			timeout = 4000,
		},
		event = "VeryLazy",
	},

	-- better ui
	{
		"KurisuNya/noice.nvim",
		keys = require("core.keymaps.lspconfig").noice_keys,
		config = require("plugins.ui.noice").config,
		dependencies = { "mfussenegger/nvim-jdtls" },
		event = "VeryLazy",
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
		lazy = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugins.ui.indent-blankline").config,
		event = "VeryLazy",
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			vim.opt.termguicolors = true
			require("colorizer").setup()
		end,
		event = "VeryLazy",
	},
	{
		"machakann/vim-highlightedyank",
		config = function()
			vim.g.highlightedyank_highlight_duration = 400
			vim.b.highlightedyank_highlight_duration = 400
		end,
		event = "VeryLazy",
	},
	{
		"anuvyklack/pretty-fold.nvim",
		config = require("plugins.ui.pretty-fold").config,
		event = "VeryLazy",
	},
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{ "karb94/neoscroll.nvim", event = "VeryLazy", opts = {} },
	{ "nacro90/numb.nvim", event = "VeryLazy", opts = {} },
	{ "nvimdev/hlsearch.nvim", event = "VeryLazy", opts = {} },
}
