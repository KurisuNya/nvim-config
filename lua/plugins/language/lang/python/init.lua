PluginVars.insert(PluginVars.neotree_hide_by_name, "__pycache__")

PluginVars.insert(PluginVars.treesitter_ensure_installed, "python")
PluginVars.insert(PluginVars.mason_ensure_installed, "basedpyright")
PluginVars.insert(PluginVars.mason_ensure_installed, "ruff")
PluginVars.insert(PluginVars.lualine_hidden_lsp, "ruff")

PluginVars.insert(PluginVars.conform_formatters, { name = "ruff_format", filetypes = { "python" } })
PluginVars.insert(PluginVars.conform_formatters, { name = "ruff_organize_imports", filetypes = { "python" } })

PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("basedpyright")
	vim.lsp.config("basedpyright", {
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "standard",
					inlayHints = { variableTypes = false },
				},
			},
		},
	})

	vim.lsp.enable("ruff")
	vim.lsp.config("ruff", {
		init_options = {
			settings = {
				fixAll = false,
				organizeImports = false,
				lint = { enable = false },
			},
		},
	})
	Utils.lsp_on_attach_by_name("ruff", function(client, _)
		client.server_capabilities.hoverProvider = false
	end)
end)

return {
	require("plugins.language.lang.python.venv-selector"),
	require("plugins.language.lang.python.nvim-dap-python"),
	require("plugins.language.lang.python.neotest-python"),
}
