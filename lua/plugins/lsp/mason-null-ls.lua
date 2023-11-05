---@diagnostic disable: missing-fields
local status, mason_null_ls = pcall(require, "mason-null-ls")
if not status then
	return
end
mason_null_ls.setup({
	automatic_installation = true,
	ensure_installed = {
		"codespell",
		"commitlint",
		"cpplint",
		"shellcheck",
		"beautysh",
		"black",
		"clang-format",
		"google-java-format",
		"prettier",
		"stylua",
	},
})
