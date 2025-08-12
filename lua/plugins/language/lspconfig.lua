PluginVars.lsp_config = {}

local opts = { noremap = true, silent = true }
local function add_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
local keymaps = {
	hover_doc = {
		key = "H",
		cmd = function()
			return vim.lsp.buf.hover()
		end,
		mode = "n",
		opts = add_desc("Lsp Hover Doc"),
	},
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		Utils.lsp_keymap_set_by_method("textDocument/hover", keymaps.hover_doc)
		for _, func in pairs(PluginVars.lsp_config) do
			func()
		end
	end,
	event = "VeryLazy",
}
