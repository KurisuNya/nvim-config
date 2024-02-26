---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	require("mason-null-ls").setup({
		automatic_installation = true,
		ensure_installed = {
			"cspell",
			"shellcheck",
			"black",
			"clang-format",
			"google-java-format",
			"prettier",
			"shfmt",
			"stylua",
		},
	})
end
return M
