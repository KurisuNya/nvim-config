PluginVars.insert(PluginVars.wrap_spell_filetypes, "markdown")
PluginVars.insert(PluginVars.treesitter_ensure_installed, "markdown")
PluginVars.insert(PluginVars.treesitter_ensure_installed, "markdown_inline")

return {
	require("plugins.language.lang.markdown.markdown-preview"),
	require("plugins.language.lang.markdown.clipboard-image"),
}
