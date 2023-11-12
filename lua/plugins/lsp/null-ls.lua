-- import null-ls plugin safely
local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_action = null_ls.builtins.code_actions

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		-- code_action
		-- formatters
		formatting.clang_format.with({
			filetypes = { "c", "cpp" },
		}),
		formatting.prettier.with({
			disabled_filetypes = { "markdown" },
		}),
		formatting.black,
		formatting.stylua,
		formatting.beautysh,
		formatting.google_java_format,
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
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
