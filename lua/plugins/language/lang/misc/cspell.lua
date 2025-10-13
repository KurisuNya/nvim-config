PluginVars.insert(PluginVars.mason_ensure_installed, "cspell-lsp")
PluginVars.insert(PluginVars.lualine_hidden_lsp, "cspell_ls")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("cspell_ls")
end)

return {}
