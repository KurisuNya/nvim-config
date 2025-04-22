local M = {}
M.config = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	local formatters = {
		formatting.black,
		formatting.clang_format.with({ filetypes = { "c", "cpp", "cuda" } }),
		formatting.google_java_format,
		formatting.prettier.with({ disabled_filetypes = { "markdown" } }),
		formatting.shfmt,
		formatting.stylua,
	}

	local linters = {
		diagnostics.fish,
	}
	if KurisuNya.utils.is_windows() then
		table.insert(linters, diagnostics.codespell)
	else
		local cspell = require("cspell")
		local opts = { disabled_filetypes = { "tex" } }
		table.insert(linters, cspell.code_actions.with(opts))
		table.insert(linters, cspell.diagnostics.with(opts))
	end

	null_ls.setup({
		sources = vim.list_extend(formatters, linters),
		fallback_severity = vim.diagnostic.severity.WARN,
	})

	local format_clients = {
		"null-ls",
		"taplo",
		"lemminx",
	}
	local filter = function(client, _)
		local is_format_client = vim.tbl_contains(format_clients, client.name)
		return is_format_client and client.supports_method("textDocument/formatting")
	end
	local format_on_save_augroup = KurisuNya.utils.create_augroup("format_on_save")
	KurisuNya.utils.lsp_on_attach(filter, function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_on_save_augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ id = client.id, bufnr = bufnr })
			end,
		})
	end)
end
return M
