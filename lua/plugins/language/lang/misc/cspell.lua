PluginVars.insert(PluginVars.mason_ensure_installed, "cspell")

local opts = { disabled_filetypes = { "tex" } }
PluginVars.insert(PluginVars.none_ls_code_actions, function()
	return require("cspell").code_actions.with(opts)
end)
PluginVars.insert(PluginVars.none_ls_linters, function()
	return require("cspell").diagnostics.with(opts)
end)

return { "davidmh/cspell.nvim" }
