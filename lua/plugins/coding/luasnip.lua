return {
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
}
