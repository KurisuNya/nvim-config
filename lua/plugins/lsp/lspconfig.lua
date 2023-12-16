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
		"rust_analyzer",
		"pyright",
	}
	for _, server in ipairs(simple_servers) do
		lspconfig[server].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	lspconfig["ruff_lsp"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.hoverProvider = false
			on_attach(client, bufnr)
		end,
		capabilities = capabilities,
	})

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

	local function get_binary_path_list(binaries)
		local path_list = {}
		for _, binary in ipairs(binaries) do
			local path = vim.fn.exepath(binary)
			if path ~= "" then
				table.insert(path_list, path)
			end
		end
		return table.concat(path_list, ",")
	end

	lspconfig["clangd"].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"-j=12",
			"--enable-config",
			"--background-index",
			"--pch-storage=memory",
			-- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
			"--query-driver="
				.. get_binary_path_list({
					"clang++",
					"clang",
					"gcc",
					"g++",
					"arm-none-eabi-gcc",
				}),
			"--clang-tidy",
			"--all-scopes-completion",
			"--completion-style=detailed",
			"--header-insertion-decorators",
			"--header-insertion=iwyu",
			"--limit-references=3000",
			"--limit-results=350",
			"--offset-encoding=utf-16",
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
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
				telemetry = { enable = false },
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
