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
	opts = {
		folding_range = true,
		inlay_hint = false,
	},

	config = function(_, opts)
		vim.lsp.log.set_level("off")

		-- hover doc
		Utils.lsp_keymap_set_by_method("textDocument/hover", keymaps.hover_doc)

		-- folding
		if opts.folding_range then
			Utils.lsp_on_attach_by_method("textDocument/foldingRange", function(client, bufnr)
				vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
			end)
		end

		-- inlay hints
		if opts.inlay_hint then
			local methods = vim.lsp.protocol.Methods
			local inlay_hint_handler = vim.lsp.handlers[methods["textDocument_inlayHint"]]
			vim.lsp.handlers[methods["textDocument_inlayHint"]] = function(err, result, ctx, config)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if client then
					local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
					result = vim.iter(result or {})
						:filter(function(hint)
							return hint.position.line + 1 == row
						end)
						:totable()
				end
				inlay_hint_handler(err, result, ctx, config)
			end
			local inlay_hints_group = Utils.create_augroup("inlay_hints")
			Utils.lsp_on_attach_by_method("textDocument/inlayHint", function(client, bufnr)
				if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = inlay_hints_group,
						buffer = bufnr,
						callback = function()
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end,
					})
				end
			end)
		end

		for _, func in pairs(PluginVars.lsp_config) do
			func()
		end
	end,
	event = "VeryLazy",
}
