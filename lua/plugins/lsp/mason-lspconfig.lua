local M = {}
M.config = function()
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"bashls",
			"clangd",
			"jdtls",
			"kotlin_language_server",
			"lemminx",
			"lua_ls",
			"pyright",
		},
	})
end
return M
