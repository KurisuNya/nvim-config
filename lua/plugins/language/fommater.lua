--- @class Formatter
--- @field name string
--- @field filetypes string[]
--- @field priority? integer
--- @field format? fun(bufnr: integer): nil

--- @type Formatter[]
PluginVars.formatters = {}

---@param bufnr integer
local format = function(bufnr)
	if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
		return
	end

	local filetype = vim.bo[bufnr].filetype
	---@type Formatter[]
	local formatters = vim.tbl_filter(function(f)
		return vim.tbl_contains(f.filetypes, filetype)
	end, PluginVars.formatters)
	table.sort(formatters, function(a, b)
		return (a.priority or 0) > (b.priority or 0)
	end)

	for _, formatter in ipairs(formatters) do
		(formatter.format or function(bufnr)
			vim.lsp.buf.format({ bufnr = bufnr, name = formatter.name })
		end)(bufnr)
	end
end

vim.api.nvim_create_user_command("BufferFormat", function(args)
	format(vim.api.nvim_get_current_buf())
end, { nargs = 0 })

if Config.format_on_save then
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = Utils.create_augroup("format_on_save"),
		callback = function(args)
			format(args.buf)
		end,
	})
end

return {}
