local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end
local lsp_inlayhints_status, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not lsp_inlayhints_status then
	return
end
local neodev_status, neodev = pcall(require, "neodev")
if not neodev_status then
	return
end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

neodev.setup({})
lsp_inlayhints.setup({ inlay_hints = { parameter_hints = { prefix = "" } } })

local on_attach = function(client, bufnr)
	lsp_inlayhints.on_attach(client, bufnr)
	require("core.keymaps.lspconfig").lsp_on_attach()
end
local capabilities = cmp_nvim_lsp.default_capabilities()

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
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, icons.hover_actions)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, icons.hover_actions)
