---@diagnostic disable: inject-field
------------------
--  ui-plugins  --
------------------
return {

	-- bars and lines
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
			vim.opt.showtabline = 0
		end,
		config = require("plugins.ui.barbar").config,
		keys = require("core.keymaps.barbar").keys,
		event = "VeryLazy",
	},
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,
		config = require("plugins.ui.lualine").config,
		event = "VeryLazy",
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
		event = "VeryLazy",
	},
	{ "linrongbin16/lsp-progress.nvim", opts = {}, event = "VeryLazy" },
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
		opts = {
			input = {
				insert_only = false,
			},
			select = {
				backend = { "telescope" },
			},
		},
		lazy = true,
	},
	{
		"yorickpeterse/nvim-pqf",
		config = require("plugins.ui.nvim-pqf").config,
		event = "VeryLazy",
	},
	{
		"lukas-reineke/virt-column.nvim",
		init = function()
			vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#3b4261", bg = "NONE" })
		end,
		opts = {
			char = "▕",
			highlight = "VirtColumn",
		},
		event = "VeryLazy",
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
