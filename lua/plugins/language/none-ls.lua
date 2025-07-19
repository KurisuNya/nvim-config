local M = {
	"nvimtools/none-ls.nvim",
	dependencies = { "jayp0521/mason-null-ls.nvim" },
	event = "VeryLazy",
}

PluginVars.none_ls_formatters = {}
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
	local formatters = vim.tbl_map(function(source)
		return get_source("formatting", source)
	end, PluginVars.none_ls_formatters)
	local linters = vim.tbl_map(function(source)
		return get_source("diagnostics", source)
	end, PluginVars.none_ls_linters)
	local code_actions = vim.tbl_map(function(source)
		return get_source("code_actions", source)
	end, PluginVars.none_ls_code_actions)
	local sources = {}
	sources = vim.list_extend(sources, formatters)
	sources = vim.list_extend(sources, linters)
	sources = vim.list_extend(sources, code_actions)

	require("null-ls").setup({
		sources = sources,
		fallback_severity = vim.diagnostic.severity.WARN,
	})

	local support_filetypes = {}
	local disabled_filetypes = {}
	for _, source in ipairs(formatters) do
		for _, ft in ipairs(source.filetypes or {}) do
			local num = support_filetypes[ft]
			support_filetypes[ft] = num and num + 1 or 1
		end
		for _, ft in ipairs(source.disabled_filetypes or {}) do
			local num = disabled_filetypes[ft]
			disabled_filetypes[ft] = num and num + 1 or 1
		end
	end
	local filetypes = vim.tbl_filter(function(ft)
		return support_filetypes[ft] > (disabled_filetypes[ft] or 0)
	end, vim.tbl_keys(support_filetypes))
	PluginVars.formatter.register({ name = "null-ls", filetypes = filetypes })
end

return M
