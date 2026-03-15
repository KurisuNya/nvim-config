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
		vim.lsp.set_log_level("off")

		Utils.lsp_keymap_set_by_method("textDocument/hover", keymaps.hover_doc)
		Utils.lsp_on_attach_by_method("textDocument/inlayHint", function(client, bufnr)
			if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end)
		Utils.lsp_on_attach_by_method("textDocument/foldingRange", function(client, bufnr)
			vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end)

		for _, func in pairs(PluginVars.lsp_config) do
			func()
		end
	end,
	event = "VeryLazy",
}
