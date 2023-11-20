-------------------
--  cmp-plugins  --
-------------------
-- snip
return {

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		event = "VeryLazy",
	},
	{
		"KurisuNya/fast-snip",
		keys = require("core.keymaps.fast-snip").keys,
		opts = {},
		event = "VeryLazy",
	},
	{ "rafamadriz/friendly-snippets" },

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		config = require("plugins.cmp.nvim-cmp").config,
		dependencies = {
			"L3MON4D3/LuaSnip",
			"abecodes/tabout.nvim",
			"windwp/nvim-autopairs",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"FelipeLema/cmp-async-path",
			"hrsh7th/cmp-cmdline",
			"kdheepak/cmp-latex-symbols",
			"lukas-reineke/cmp-under-comparator",
		},
		event = "VeryLazy",
	},
	{ "abecodes/tabout.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },
	{ "FelipeLema/cmp-async-path", event = "VeryLazy" },
	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "kdheepak/cmp-latex-symbols", event = "VeryLazy" },
	{ "lukas-reineke/cmp-under-comparator", event = "VeryLazy" },
}
