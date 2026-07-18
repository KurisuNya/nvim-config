PluginVars.insert(PluginVars.treesitter_ensure_installed, "odin")
PluginVars.insert(PluginVars.mason_ensure_installed, "ols")
PluginVars.insert(PluginVars.conform_formatters, { name = "odinfmt", filetypes = { "odin" } })

PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("ols")
end)

return {}
