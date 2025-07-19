--- @class Formatter
--- @field name string
--- @field filetypes string[]
--- @field priority? integer
--- @field format? fun(bufnr: integer): nil

--- @type Formatter[]

local M = {}

M.formatters = {} ---@type Formatter[]

---@param formatter Formatter
M.register = function(formatter)
	table.insert(M.formatters, formatter)
	table.sort(M.formatters, function(a, b)
		return (a.priority or 0) > (b.priority or 0)
	end)
end

---@param bufnr integer
M.format = function(bufnr)
	if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
		return
	end
	---@type Formatter[]
	local formatters = vim.tbl_filter(function(f)
		return vim.tbl_contains(f.filetypes, vim.bo[bufnr].filetype)
	end, M.formatters)
	for _, formatter in ipairs(formatters) do
		local format_by_name = function(bufnr)
			vim.lsp.buf.format({ bufnr = bufnr, name = formatter.name })
		end
		(formatter.format or format_by_name)(bufnr)
	end
end

PluginVars.formatter = M

if Config.format_on_save then
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = Utils.create_augroup("format_on_save"),
		callback = function(args)
			PluginVars.formatter.format(args.buf)
		end,
	})
end

return {}
