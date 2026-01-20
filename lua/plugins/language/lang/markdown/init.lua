PluginVars.insert(PluginVars.wrap_spell_filetypes, "markdown")
PluginVars.insert(PluginVars.treesitter_ensure_installed, "markdown")
PluginVars.insert(PluginVars.treesitter_ensure_installed, "markdown_inline")

vim.api.nvim_create_autocmd("FileType", {
	group = Utils.create_augroup("auto_wrap_markdown"),
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

return {
	require("plugins.language.lang.markdown.markdown-preview"),
	require("plugins.language.lang.markdown.clipboard-image"),
}
