PluginVars.insert(PluginVars.neotree_hide_by_name, "__pycache__")

PluginVars.insert(PluginVars.treesitter_ensure_installed, "python")
PluginVars.insert(PluginVars.mason_ensure_installed, "pyright")
PluginVars.insert(PluginVars.mason_ensure_installed, "black")

PluginVars.insert(PluginVars.none_ls_formatters, "black")
PluginVars.insert(PluginVars.lsp_config, function()
	vim.lsp.enable("pyright")
	-- HACK: fix lspconfig defaults
	vim.lsp.config("pyright", {
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
				local params = {
					command = "pyright.organizeimports",
					arguments = { vim.uri_from_bufnr(bufnr) },
				}
				client:request("workspace/executeCommand", params, nil, 0)
			end, { desc = "Organize Imports" })
		end,
	})
	Utils.lsp_keymap_set_by_name("pyright", {
		key = "<leader>co",
		cmd = "<CMD>LspPyrightOrganizeImports<CR>",
		mode = "n",
		opts = { noremap = true, silent = true, desc = "Pyright Organize Imports" },
	})
end)

return {
	require("plugins.language.lang.python.venv-selector"),
	require("plugins.language.lang.python.nvim-dap-python"),
	require("plugins.language.lang.python.neotest-python"),
}
