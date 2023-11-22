local M = {}
M.config = function()
	require("mason-null-ls").setup({
		automatic_installation = true,
		ensure_installed = {
			"commitlint",
			"cpplint",
			"markdownlint",
			"misspell",
			"shellcheck",
			"beautysh",
			"black",
			"clang-format",
			"google-java-format",
			"prettier",
			"rustfmt",
			"stylua",
			"xmlformatter",
		},
	})
end
return M
