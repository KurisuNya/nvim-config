local M = {
	require("plugins.language.mason"),
	require("plugins.language.treesitter"),
	require("plugins.language.lspconfig"),
	require("plugins.language.lspsaga"),
	require("plugins.language.nvim-gtd"),
	require("plugins.language.inlay-hints"),
	require("plugins.language.none-ls"),
	require("plugins.language.nvim-dap"),
	require("plugins.language.neotest"),
	-- lang
	require("plugins.language.lang.misc"),
	require("plugins.language.lang.markdown"),
	require("plugins.language.lang.lua"),
	require("plugins.language.lang.c"),
	require("plugins.language.lang.python"),
}

return M
