PluginVars.insert(PluginVars.treesitter_ensure_installed, "haskell")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("hls")
end)

return {}
