local M = {}
M.config = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local cspell = require("cspell")
	local cspell_config = {
		find_json = function(cwd)
			return vim.fn.expand(vim.fn.stdpath("data") .. "/cspell.json")
		end,
	}

	null_ls.setup({
		sources = {
			-- code actions
			cspell.code_actions.with({ config = cspell_config }),
			-- formatters
			formatting.clang_format.with({
				filetypes = { "c", "cpp" },
			}),
			formatting.prettier.with({
				disabled_filetypes = { "markdown" },
			}),
			formatting.beautysh,
			formatting.black,
			formatting.google_java_format,
			formatting.rustfmt,
			formatting.stylua,
			formatting.xmlformat,
			-- linters
			cspell.diagnostics.with({ config = cspell_config }),
			diagnostics.commitlint,
			diagnostics.cpplint,
			diagnostics.markdownlint,
		},
		-- configure format on save
		on_attach = function(current_client, bufnr)
			require("core.keymaps.lspconfig").null_ls_on_attach()
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
		fallback_severity = vim.diagnostic.severity.WARN,
	})
end
return M
