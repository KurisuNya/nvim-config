---@diagnostic disable: missing-fields
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

local function plugin_exist(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

local M = {}
M.config = function()
	if plugin_exist("neoconf.nvim") then
		local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
		require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
	end

	local lspconfig = require("lspconfig")

	-- lsp on_attach
	local function on_attach(client, bufnr)
		require("core.keymaps.lspconfig").lspconfig_on_attach(client, bufnr)
	end

	-- lsp-server settings
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local simple_servers = {
		"bashls",
		"lemminx",
		"taplo",
	}
	for _, server in ipairs(simple_servers) do
		lspconfig[server].setup({
			capabilities = capabilities,
		})
	end

	lspconfig["clangd"].setup({
		capabilities = capabilities,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
			-- You MUST set this arg ↓ to your c/cpp compiler location (if not included)!
			"--query-driver="
				.. get_binary_path_list({
					"clang++",
					"clang",
					"gcc",
					"g++",
					"arm-none-eabi-gcc",
				}),
			"-j=12",
			"--enable-config",
			"--background-index",
			"--pch-storage=memory",
			"--clang-tidy",
			"--all-scopes-completion",
			"--completion-style=detailed",
			"--suggest-missing-includes",
			"--function-arg-placeholders=false",
			"--header-insertion-decorators",
			"--header-insertion=iwyu",
			"--limit-references=3000",
			"--limit-results=350",
			"--cross-file-rename",
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

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lspconfig_attach", {}),
		callback = function(args)
			local bufnr = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, bufnr)
		end,
	})

	-- lsp-ui
	local icons = require("plugins.ui.icons")
	vim.diagnostic.config({
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
		},
		signs = {
			text = {
				[1] = icons.diagnostics.Error,
				[2] = icons.diagnostics.Warning,
				[3] = icons.diagnostics.Info,
				[4] = icons.diagnostics.Hint,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end
return M
