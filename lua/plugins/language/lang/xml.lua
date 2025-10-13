PluginVars.insert(PluginVars.treesitter_ensure_installed, "xml")
PluginVars.insert(PluginVars.mason_ensure_installed, "xmlformatter")
PluginVars.insert(PluginVars.conform_formatters, { name = "xmlformatter", filetypes = { "xml" } })

return {}
