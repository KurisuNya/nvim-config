local M = {
	"nvimtools/none-ls.nvim",
	dependencies = { "jayp0521/mason-null-ls.nvim" },
	event = "VeryLazy",
}

PluginVars.none_ls_formatters = {}
PluginVars.other_lsp_formatters = {}
PluginVars.none_ls_linters = {}
PluginVars.none_ls_code_actions = {}

local get_source = function(type_, source)
	if type(source) == "string" then
		return require("null-ls").builtins[type_][source]
	elseif type(source) == "function" then
		return source()
	elseif type(source) == "table" then
		local name = source[1] or source.name
		local opts = source[2] or source.opts or {}
		return require("null-ls").builtins[type_][name].with(opts)
	else
		error("Invalid source type: " .. type(source))
	end
end

M.init = function()
	PluginVars.insert(PluginVars.lualine_hidden_lsp, "null-ls")
end

M.config = function()
	local sources = {}
	sources = vim.list_extend(
		sources,
		vim.tbl_map(function(source)
			return get_source("formatting", source)
		end, PluginVars.none_ls_formatters)
	)
	sources = vim.list_extend(
		sources,
		vim.tbl_map(function(source)
			return get_source("diagnostics", source)
		end, PluginVars.none_ls_linters)
	)
	sources = vim.list_extend(
		sources,
		vim.tbl_map(function(source)
			return get_source("code_actions", source)
		end, PluginVars.none_ls_code_actions)
	)

	require("null-ls").setup({
		sources = sources,
		fallback_severity = vim.diagnostic.severity.WARN,
	})

	local format_clients = { "null-ls" }
	format_clients = vim.list_extend(format_clients, PluginVars.other_lsp_formatters)

	local filter = function(client, _)
		return vim.tbl_contains(format_clients, client.name)
	end

	local format_on_save = Utils.create_augroup("format_on_save")
	Utils.lsp_on_attach(filter, function(_, bufnr)
		vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_on_save,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end)
end

return M
