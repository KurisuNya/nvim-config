local M = {}
local opts = { noremap = true, silent = true }
local function extend_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
M.keymaps = {
	hover_doc = {
		key = "H",
		cmd = vim.lsp.buf.hover,
		mode = "n",
		opts = extend_desc("Lsp Hover Doc"),
	},
	signature_help = {
		key = "gH",
		cmd = vim.lsp.buf.signature_help,
		mode = "n",
		opts = extend_desc("Lsp Signature Help"),
	},
	signature_help_insert = {
		key = "<C-h>",
		cmd = vim.lsp.buf.signature_help,
		mode = "i",
		opts = extend_desc("Lsp Signature Help"),
	},
}
M.client_specific = {
	pyright = {
		{
			key = "<leader>co",
			cmd = "<Cmd>PyrightOrganizeImports<CR>",
			mode = "n",
			opts = extend_desc("Code Organize Imports"),
		},
	},
	jdtls = M.keymaps,
}
return M
