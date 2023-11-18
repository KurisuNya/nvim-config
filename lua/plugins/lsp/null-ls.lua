local M = {}
M.config = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_action = null_ls.builtins.code_actions
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		sources = {
			-- code_action
			-- formatters
			formatting.clang_format.with({
				filetypes = { "c", "cpp" },
			}),
			formatting.prettier.with({
				disabled_filetypes = { "markdown" },
			}),
			formatting.rustfmt,
			formatting.black,
			formatting.stylua,
			formatting.beautysh,
			formatting.google_java_format,
			formatting.xmlformat,
			-- linters
			diagnostics.cpplint,
			diagnostics.codespell,
			diagnostics.commitlint,
			diagnostics.markdownlint,
		},
		-- configure format on save
		on_attach = function(current_client, bufnr)
			if current_client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(client)
								return client.name == "null-ls"
							end,
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
end
return M
