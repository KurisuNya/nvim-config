PluginVars.insert(PluginVars.neotree_hide_by_name, "__pycache__")

PluginVars.insert(PluginVars.treesitter_ensure_installed, "python")
PluginVars.insert(PluginVars.mason_ensure_installed, "pyright")
PluginVars.insert(PluginVars.mason_ensure_installed, "black")
PluginVars.insert(PluginVars.mason_ensure_installed, "isort")

PluginVars.insert(PluginVars.conform_formatters, { name = "black", filetypes = { "python" } })
PluginVars.insert(PluginVars.conform_formatters, { name = "isort", filetypes = { "python" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("pyright")
end)

return {
	require("plugins.language.lang.python.venv-selector"),
	require("plugins.language.lang.python.nvim-dap-python"),
	require("plugins.language.lang.python.neotest-python"),
}
