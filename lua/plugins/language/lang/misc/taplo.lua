PluginVars.insert(PluginVars.mason_ensure_installed, "taplo")

PluginVars.insert(PluginVars.other_lsp_formatters, "taplo")

PluginVars.formatter.register({ name = "taplo", filetypes = { "toml" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("taplo")
end)

return {}
