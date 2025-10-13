PluginVars.insert(PluginVars.treesitter_ensure_installed, "lua")
PluginVars.insert(PluginVars.mason_ensure_installed, "lua-language-server")
PluginVars.insert(PluginVars.mason_ensure_installed, "stylua")

PluginVars.insert(PluginVars.conform_formatters, { name = "stylua", filetypes = { "lua" } })
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("lua_ls")
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				codeLens = { enable = true },
				completion = { callSnippet = "Replace" },
				doc = { privateName = { "^_" } },
				hint = {
					enable = true,
					setType = false,
					paramType = true,
					paramName = "Disable",
					semicolon = "Disable",
					arrayIndex = "Disable",
				},
			},
		},
	})
end)

return {
	require("plugins.language.lang.lua.lazydev"),
}
