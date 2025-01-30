local M = {
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		config = require("plugins.coding.nvim-treesitter").config,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
		},
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	-- cmp and snip
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = { history = true, delete_check_events = "TextChanged" },
		build = "make install_jsregexp",
		event = "VeryLazy",
	},
	{
		"danymat/neogen",
		keys = require("keymaps.plugins.neogen").keys,
		opts = function()
			local opts = {}
			local map = {
				["LuaSnip"] = "luasnip",
				["nvim-snippy"] = "snippy",
				["vim-vsnip"] = "vsnip",
			}
			for plugin, engine in pairs(map) do
				if KurisuNya.utils.plugin_exist(plugin) then
					opts.snippet_engine = engine
					break
				end
			end
			return opts
		end,
		event = "VeryLazy",
	},
	{
		"iguanacucumber/magazine.nvim",
		name = "nvim-cmp",
		config = require("plugins.coding.nvim-cmp").config,
		dependencies = {
			{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
			{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
			{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
			{ url = "https://codeberg.org/FelipeLema/cmp-async-path.git" },
			"saadparwaiz1/cmp_luasnip",
			"kdheepak/cmp-latex-symbols",
			{ "kawre/neotab.nvim", opts = { tabkey = "", behavior = "closing" }, event = "VeryLazy" },
		},
		event = "VeryLazy",
	},
	-- move
	{
		"ggandor/leap.nvim",
		keys = require("keymaps.plugins.leap-nvim").keys,
		event = "VeryLazy",
	},
	{ "ggandor/leap-spooky.nvim", opts = {}, event = "VeryLazy" },
	-- operate
	{
		"nguyenvukhang/nvim-toggler",
		keys = require("keymaps.plugins.nvim-toggler").keys,
		config = require("plugins.coding.nvim-toggler").config,
		event = "VeryLazy",
	},
	{ "numToStr/Comment.nvim", opts = {}, event = "VeryLazy" },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{
		"echasnovski/mini.ai",
		config = require("plugins.coding.mini-ai").config,
		event = "VeryLazy",
	},
	{
		"dhruvasagar/vim-table-mode",
		keys = require("keymaps.plugins.vim-table-mode").keys,
		init = function()
			local module = require("keymaps.plugins.vim-table-mode")
			vim.g.table_mode_map_prefix = module.table_mode_map_prefix
			vim.g.table_mode_toggle_map = module.table_mode_toggle_map
			vim.g.table_mode_tableize_map = module.table_mode_tableize_map
			vim.g.table_mode_corner = module.table_mode_corner
		end,
		event = "VeryLazy",
	},
	-- enhance
	{
		"echasnovski/mini.pairs",
		config = require("plugins.coding.mini-pairs").config,
		event = "VeryLazy",
	},
	{ "windwp/nvim-ts-autotag", opts = {}, event = "VeryLazy" },
}

if KurisuNya.config.use_copilot then
	table.insert(M, {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = { markdown = true, help = true },
		},
	})
	table.insert(M, { "KurisuNya/copilot-cmp", opts = {} })
	for _, plugin in ipairs(M) do
		if type(plugin) == "table" and plugin[1] == "iguanacucumber/magazine.nvim" then
			table.insert(plugin.dependencies, "zbirenbaum/copilot.lua")
			table.insert(plugin.dependencies, "KurisuNya/copilot-cmp")
		end
	end
end
return M
