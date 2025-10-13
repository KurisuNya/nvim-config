PluginVars.insert(PluginVars.treesitter_ensure_installed, "toml")
PluginVars.insert(PluginVars.mason_ensure_installed, "taplo")
PluginVars.insert(PluginVars.conform_formatters, { name = "taplo", filetypes = { "toml" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("taplo")
end)

return {}
