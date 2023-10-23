---@diagnostic disable: missing-fields
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end
mason_null_ls.setup({
	automatic_installation = true,
	ensure_installed = {
		"cpptools",
		"codespell",
		"cpplint",
		"shellcheck",
		"autopep8",
		"beautysh",
		"clang-format",
		"google-java-format",
		"prettier",
		"stylua",
	},
})
