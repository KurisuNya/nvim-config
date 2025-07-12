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
	signature_help = {
		key = "gH",
		cmd = function()
			return vim.lsp.buf.signature_help()
		end,
		mode = "n",
		opts = add_desc("Lsp Signature Help"),
	},
	signature_help_insert = {
		key = "<C-h>",
		cmd = function()
			return vim.lsp.buf.signature_help()
		end,
		mode = "i",
		opts = add_desc("Lsp Signature Help"),
	},
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		Utils.lsp_keymap_set_by_method("textDocument/hover", keymaps.hover_doc)
		Utils.lsp_keymap_set_by_method("textDocument/signatureHelp", keymaps.signature_help)
		Utils.lsp_keymap_set_by_method("textDocument/signatureHelp", keymaps.signature_help_insert)
		for _, func in pairs(PluginVars.lsp_config) do
			func()
		end
	end,
	event = "VeryLazy",
}
