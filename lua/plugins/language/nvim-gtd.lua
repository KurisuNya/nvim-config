local goto_definition = {
	key = "gd",
	cmd = function()
		require("gtd").exec({ command = "edit" })
	end,
	mode = "n",
	opts = {
		desc = "Lsp Goto Definition",
		noremap = true,
		silent = true,
	},
}

return {
	"KurisuNya/nvim-gtd",
	config = function()
		require("gtd").setup({})
		Utils.lsp_keymap_set_by_method("textDocument/definition", goto_definition)
	end,
	event = "VeryLazy",
}
