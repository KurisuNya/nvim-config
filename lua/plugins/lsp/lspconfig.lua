local M = {}
M.config = function()
	local lspconfig = require("lspconfig")
	local lsp_inlayhints = require("lsp-inlayhints")

	require("neodev").setup({})
	lsp_inlayhints.setup({ inlay_hints = { parameter_hints = { prefix = "" } } })

	local on_attach = function(client, bufnr)
		lsp_inlayhints.on_attach(client, bufnr)
		require("core.keymaps.lspconfig").lsp_on_attach()
	end
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- lsp-server settings
	lspconfig["bashls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	lspconfig["clangd"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
			"--background-index",
			"--suggest-missing-includes",
		},
	})
	lspconfig["lua_ls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				hint = {
					enable = true,
				},
				completion = {
					callSnippet = "Replace",
				},
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					checkThirdParty = "Disable",
				},
			},
		},
	})
	lspconfig["pylsp"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391" },
						maxLineLength = 100,
					},
				},
			},
		},
	})
	lspconfig["rust_analyzer"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
	lspconfig["lemminx"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- lsp-ui
	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
	end
	local icons = require("plugins.ui.icons")
	lspSymbol("Error", icons.diagnostics.Error)
	lspSymbol("Info", icons.diagnostics.Info)
	lspSymbol("Hint", icons.diagnostics.Hint)
	lspSymbol("Warn", icons.diagnostics.Warning)
	vim.diagnostic.config({
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
		},
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end
return M
