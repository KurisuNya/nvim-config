local M = {}
M.config = function()
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"bashls",
			"clangd",
			"jdtls",
			"lemminx",
			"lua_ls",
			"pylsp",
			"rust_analyzer",
		},
	})
end
return M
