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
		event = "BufReadPre",
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
		event = "BufReadPre",
	},
	{ "linrongbin16/lsp-progress.nvim", opts = {} },

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
	},
	{
		"stevearc/quicker.nvim",
		opts = {},
		event = "FileType qf",
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
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RRGGBBAA = true,
					AARRGGBB = true,
					tailwind = true,
					names = false,
					always_update = true,
				},
			})
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
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{ "karb94/neoscroll.nvim", opts = {}, event = "VeryLazy" },
	{ "nacro90/numb.nvim", opts = {}, event = "VeryLazy" },
	{ "nvimdev/hlsearch.nvim", opts = {}, event = "VeryLazy" },
}
