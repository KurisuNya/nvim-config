local M = {}
M.config = function()
	require("gtd").setup({})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("gtd_attach", {}),
		callback = function(args)
			local bufnr = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			require("core.keymaps.lspconfig").gtd_on_attach(client, bufnr)
		end,
	})
end
return M
