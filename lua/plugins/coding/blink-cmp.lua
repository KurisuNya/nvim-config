local M = {
	"saghen/blink.cmp",
	version = "*",
	event = "VeryLazy",
}

M.dependencies = {
	{ "kawre/neotab.nvim", opts = {} },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { vim.fn.stdpath("config") .. "/snippets" },
				})
			end,
		},
		opts = { history = true, delete_check_events = "TextChanged" },
		build = "make install_jsregexp",
	},
}

M.opts = {
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "fallback" },
		["<C-e>"] = { "hide", "fallback" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<C-y>"] = { "select_and_accept", "fallback" },

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },

		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		["<CR>"] = { "accept", "cancel", "fallback" },

		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},

	snippets = { preset = "luasnip" },
	signature = {
		enabled = true,
		window = { border = Config.cmp_border_style },
	},
	completion = {
		menu = { border = Config.cmp_border_style },
		accept = { auto_brackets = { enabled = false } },
		list = { selection = { preselect = false, auto_insert = true } },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = Config.cmp_border_style },
		},
	},
	cmdline = {
		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			menu = { auto_show = true },
		},
	},
}

return M
