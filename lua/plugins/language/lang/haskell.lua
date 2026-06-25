PluginVars.insert(PluginVars.treesitter_ensure_installed, "haskell")
PluginVars.insert(PluginVars.mason_ensure_installed, "ormolu")
PluginVars.insert(PluginVars.conform_formatters, { name = "ormolu", filetypes = { "haskell" } })

PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("hls")
end)

return {}
