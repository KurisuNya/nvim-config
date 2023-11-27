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
	local simple_servers = {
		"bashls",
		"lemminx",
		"pyright",
		"rust_analyzer",
	}
	for _, server in ipairs(simple_servers) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	lspconfig["matlab_ls"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			matlab = {
				indexWorkspace = true,
				installPath = "/home/kurisunya/Matlab",
				matlabConnectionTiming = "onStart",
				telemetry = true,
			},
		},
		single_file_support = true,
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
