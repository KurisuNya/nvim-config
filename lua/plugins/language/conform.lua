local M = {
	"stevearc/conform.nvim",
	event = "VeryLazy",
}

--- @class ConformFormatter
--- @field name string
--- @field filetypes string[]
--- @field priority? integer
--- @field config? table<string, any>

--- @type ConformFormatter[]
PluginVars.conform_formatters = {}

M.config = function()
	local formatters = PluginVars.conform_formatters
	table.sort(formatters, function(a, b)
		return (a.priority or 0) > (b.priority or 0)
	end)

	local filetype_formatters = {}
	for _, formatter in ipairs(formatters) do
		for _, ft in ipairs(formatter.filetypes) do
			if not filetype_formatters[ft] then
				filetype_formatters[ft] = {}
			end
			table.insert(filetype_formatters[ft], formatter.name)
		end
	end
	local filetypes = vim.tbl_keys(filetype_formatters)

	require("conform").setup({ formatters_by_ft = filetype_formatters })
	for _, formatter in ipairs(formatters) do
		if formatter.config then
			require("conform").formatters[formatter.name] = formatter.config
		end
	end
	PluginVars.formatter.register({
		name = "conform",
		filetypes = filetypes,
		priority = 100,
		format = function(bufnr)
			require("conform").format({ bufnr = bufnr })
		end,
	})
end

return M
