local M = {}
M.config = function()
	require("mason-null-ls").setup({
		automatic_installation = true,
		ensure_installed = {
			"codespell",
			"commitlint",
			"cpplint",
			"markdownlint",
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
