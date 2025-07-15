PluginVars.insert(PluginVars.mason_ensure_installed, "prettierd")

PluginVars.prettier_filetypes = {
	"css",
	"scss",
	"html",
	"json",
	"jsonc",
	"yaml",
	"markdown",
	"markdown.mdx",
}

PluginVars.insert(PluginVars.none_ls_formatters, function()
	local cfg_path = vim.fn.stdpath("config") .. "/lua/plugins/language/lang/misc/prettier.json"
	local opts = {
		filetypes = PluginVars.prettier_filetypes,
		env = { PRETTIERD_DEFAULT_CONFIG = cfg_path },
	}
	return require("null-ls").builtins.formatting.prettierd.with(opts)
end)

return {}
