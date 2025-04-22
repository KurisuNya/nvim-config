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

local function find_git_ancestor(fname)
	return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
end

local M = {}
M.config = function()
	local lspconfig = require("lspconfig")

	local simple_servers = {
		"bashls",
		"jsonls",
		"lemminx",
		"neocmake",
		"taplo",
		"texlab",
	}
	for _, server in ipairs(simple_servers) do
		lspconfig[server].setup({})
	end

	lspconfig["clangd"].setup({
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

	lspconfig["pyright"].setup({
		root_dir = function(fname)
			local root_files = {
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				"pyrightconfig.json",
			}
			return lspconfig.util.root_pattern(unpack(root_files))(fname) or find_git_ancestor(fname) or vim.fn.getcwd()
		end,
	})

	local keymaps = require("keymaps.plugins.lspconfig").keymaps
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/hover", keymaps.hover_doc)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/signatureHelp", keymaps.signature_help)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/signatureHelp", keymaps.signature_help_insert)
	local client_specific_keymaps = require("keymaps.plugins.lspconfig").client_specific
	for client, c_keymaps in pairs(client_specific_keymaps) do
		for _, keymap in pairs(c_keymaps) do
			KurisuNya.utils.lsp_keymap_set_by_client(client, keymap)
		end
	end
end
return M
