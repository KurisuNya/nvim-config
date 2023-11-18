local M = {}
M.config = function()
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"bashls",
			"clangd",
			"jdtls",
			"pylsp",
			"lua_ls",
			"rust_analyzer",
		},
	})
end
return M
