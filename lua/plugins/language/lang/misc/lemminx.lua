PluginVars.insert(PluginVars.mason_ensure_installed, "lemminx")

PluginVars.insert(PluginVars.other_lsp_formatters, "lemminx")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("lemminx")
end)

return {}
