PluginVars.insert(PluginVars.mason_ensure_installed, "lemminx")

PluginVars.formatter.register({ name = "lemminx", filetypes = { "xml" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("lemminx")
end)

return {}
