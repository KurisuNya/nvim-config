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

local M = {}
M.config = function()
	local lspconfig = require("lspconfig")
	local lsp_inlayhints = require("lsp-inlayhints")

	require("neodev").setup({})
	lsp_inlayhints.setup({ inlay_hints = { parameter_hints = { prefix = "" } } })

	-- lsp-server settings
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local simple_servers = {
		"bashls",
		"lemminx",
	}
	for _, server in ipairs(simple_servers) do
		lspconfig[server].setup({
			capabilities = capabilities,
		})
	end

	lspconfig["pyright"].setup({
		capabilities = capabilities,
		root_dir = function(fname)
			local root_files = {
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				"pyrightconfig.json",
			}
			return lspconfig.util.root_pattern(unpack(root_files))(fname)
				or lspconfig.util.find_git_ancestor(fname)
				or vim.fn.getcwd()
		end,
	})

	lspconfig["clangd"].setup({
		capabilities = capabilities,
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
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
				telemetry = { enable = false },
			},
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lspconfig_attach", {}),
		callback = function(args)
			local bufnr = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			lsp_inlayhints.on_attach(client, bufnr)
			require("core.keymaps.lspconfig").lspconfig_on_attach(client, bufnr)
		end,
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
