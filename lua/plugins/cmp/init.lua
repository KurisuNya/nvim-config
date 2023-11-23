-------------------
--  cmp-plugins  --
-------------------
local M = {

	-- snip
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
	{
		"danymat/neogen",
		keys = require("core.keymaps.neogen").keys,
		opts = {
			snippet_engine = "luasnip",
		},
		event = "VeryLazy",
	},
	{ "rafamadriz/friendly-snippets" },

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		config = require("plugins.cmp.nvim-cmp").config,
		dependencies = {
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
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{ "zbirenbaum/copilot-cmp", opts = {} },
	{ "abecodes/tabout.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "FelipeLema/cmp-async-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "kdheepak/cmp-latex-symbols" },
	{ "lukas-reineke/cmp-under-comparator" },
}

---@diagnostic disable-next-line: undefined-field
if _G.use_copilot then
	for _, plugin in ipairs(M) do
		local from, _ = plugin[1]:find("nvim%-cmp")
		if from then
			table.insert(plugin.dependencies, "zbirenbaum/copilot-cmp")
			table.insert(plugin.dependencies, "zbirenbaum/copilot.lua")
		end
	end
end
return M
