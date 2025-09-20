PluginVars.insert(PluginVars.treesitter_ensure_installed, "toml")
PluginVars.insert(PluginVars.mason_ensure_installed, "taplo")
PluginVars.formatter.register({ name = "taplo", filetypes = { "toml" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("taplo")
end)

return {}
