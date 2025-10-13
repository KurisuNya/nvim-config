PluginVars.insert(PluginVars.mason_ensure_installed, "cspell-lsp")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("cspell_ls")
end)

return {}
