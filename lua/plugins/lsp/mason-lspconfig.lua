local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end
mason_lspconfig.setup({
	ensure_installed = {
		-- "prettier",
		-- "black",
		-- "clang-format",
		-- "clangd",
		-- "codespell",
		-- "commitlint",
		-- "cpplint",
		-- "google-java-format",
		-- "jdtls",
		-- "lua-language-server",
		-- "python-lsp-server",
		-- "stylua",
	},
})
