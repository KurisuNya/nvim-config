---@diagnostic disable: missing-fields
local M = {}
local ensure_installed = {
	"shellcheck",
	"black",
	"clang-format",
	"google-java-format",
	"ktlint",
	"prettier",
	"shfmt",
	"stylua",
}
if vim.loop.os_uname().sysname == "Windows_NT" then
	table.insert(ensure_installed, "codespell")
else
	table.insert(ensure_installed, "cspell")
end

M.config = function()
	require("mason-null-ls").setup({
		automatic_installation = true,
		ensure_installed = ensure_installed,
	})
end
return M
