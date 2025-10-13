PluginVars.insert(PluginVars.mason_ensure_installed, "typos-lsp")
PluginVars.insert(PluginVars.lualine_hidden_lsp, "typos_lsp")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("typos_lsp")
end)

return {}
