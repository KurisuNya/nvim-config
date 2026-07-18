PluginVars.insert(PluginVars.treesitter_ensure_installed, "zig")
PluginVars.insert(PluginVars.mason_ensure_installed, "zls")
PluginVars.formatter.register({ name = "zls", filetypes = { "zig" } })

PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("zls")
end)

return {}
