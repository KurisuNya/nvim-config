---@diagnostic disable: missing-fields
require("plugins.ui.diagnostic")
local M = {
	-- colorscheme
	{
		"folke/tokyonight.nvim",
		config = require("plugins.ui.tokyonight").config,
		lazy = false,
		priority = 1000,
	},
	-- dashboard
	{
		"goolord/alpha-nvim",
		config = require("plugins.ui.alpha-nvim").config,
		event = "VimEnter",
	},
	-- bar and line
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
			vim.opt.showtabline = 0
		end,
		config = require("plugins.ui.barbar").config,
		keys = require("keymaps.plugins.barbar").keys,
		event = "BufReadPre",
	},
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			vim.opt.showmode = false
			vim.opt.ruler = false
			vim.opt.cmdheight = 0
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
	-- better ui
	{
		"stevearc/dressing.nvim",
		init = require("plugins.ui.dressing-nvim").init,
		config = require("plugins.ui.dressing-nvim").config,
	},
	{
		"KurisuNya/noice.nvim",
		keys = require("keymaps.plugins.noice").keys,
		config = require("plugins.ui.noice").config,
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-notify",
		opts = { render = "wrapped-compact", stages = "static", timeout = 4000 },
		event = "VeryLazy",
	},
	{ "stevearc/quicker.nvim", opts = {}, event = "FileType qf" },
	{
		"lukas-reineke/virt-column.nvim",
		opts = { char = "▕", highlight = "VirtColumn" },
		event = "VeryLazy",
	},
	{ "stevearc/stickybuf.nvim", opts = {}, event = "VeryLazy" },
}
return M
