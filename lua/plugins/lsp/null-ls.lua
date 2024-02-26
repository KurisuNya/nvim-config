local M = {}
M.config = function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local cspell = require("cspell")
	local cspell_config = {
		find_json = function(cwd)
			return vim.fn.expand(vim.fn.stdpath("data") .. "/cspell.json")
		end,
	}

	null_ls.setup({
		sources = {
			-- code actions
			cspell.code_actions.with({ config = cspell_config }),
			-- formatters
			formatting.clang_format.with({
				filetypes = { "c", "cpp" },
			}),
			formatting.prettier.with({
				disabled_filetypes = { "markdown" },
			}),
			formatting.black,
			formatting.google_java_format,
			formatting.shfmt,
			formatting.stylua,
			-- linters
			cspell.diagnostics.with({ config = cspell_config }),
		},
		fallback_severity = vim.diagnostic.severity.WARN,
	})

	local specific_clients = {
		"taplo",
		"lemminx",
	}

	local augroup = vim.api.nvim_create_augroup("null_ls_attach", {})

	local function is_specific_client(client_name)
		if vim.tbl_contains(specific_clients, client_name) then
			return true
		end
		return false
	end

	local function null_ls_format(args)
		local buffer = args.buf ---@type number
		vim.lsp.buf.format({
			filter = function(client)
				return client.name == "null-ls" or is_specific_client(client.name)
			end,
			bufnr = buffer,
		})
	end

	local function format_on_save(bufnr)
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = null_ls_format,
		})
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.supports_method("textDocument/formatting") then
				format_on_save(bufnr)
			end
		end,
	})
end
return M
