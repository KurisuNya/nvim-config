---@diagnostic disable: undefined-field
local icons = require("plugins.ui.icons")
local compare = require("cmp.config.compare")

local M = {}

local function to_table(value)
	return type(value) ~= "table" and { value } or value
end
M.cmp_format = function(opts)
	return function(entry, vim_item)
		-- kind string
		local cmp_icons = vim.tbl_deep_extend("force", icons.symbols, icons.cmp)
		local ellipsis_char = opts.ellipsis_char or "..."
		vim_item.kind = string.format(" %s %s ", cmp_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")
		-- disable menu for specific filetypes
		local disable_menu = false
		for _, filetype in ipairs(to_table(opts.disable_menu_filetype)) do
			if vim.bo.ft == filetype then
				disable_menu = true
				break
			end
		end
		-- menu string
		if not disable_menu and opts.menu ~= nil then
			vim_item.menu = opts.menu[entry.source.name] or "[UDEF]"
		end
		-- format abbr and menu
		if opts.label_maxwidth ~= nil then
			local abbr = vim_item.abbr
			local truncated_abbr = vim.fn.strcharpart(abbr, 0, opts.label_maxwidth)
			if truncated_abbr ~= abbr then
				vim_item.abbr = truncated_abbr .. ellipsis_char
			end
		end
		if opts.menu_maxwidth ~= nil then
			local menu = vim_item.menu
			if menu ~= nil then
				local truncated_menu = vim.fn.strcharpart(menu, 0, opts.menu_maxwidth)
				if truncated_menu ~= menu then
					vim_item.menu = truncated_menu .. ellipsis_char
				end
			end
		end
		return vim_item
	end
end

M.get_sources = function()
	local sources = {
		{ name = "nvim_lsp", max_item_count = 350 },
		{ name = "luasnip" },
		{ name = "async_path" },
		{ name = "buffer", max_item_count = 5 },
	}
	if _G.use_copilot then
		table.insert(sources, { name = "copilot" })
	end
	return sources
end

M.get_markdown_sources = function()
	local sources = {
		{ name = "buffer" },
		{ name = "async_path" },
		{ name = "latex_symbols", option = { strategy = 2 } },
	}
	if _G.use_copilot then
		table.insert(sources, { name = "copilot" })
	end
	return sources
end

local function lsp_scores(entry1, entry2)
	local diff
	if entry1.completion_item.score and entry2.completion_item.score then
		diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
	else
		diff = entry2.score - entry1.score
	end
	return (diff < 0)
end

M.get_comparators = function()
	local comparators = {
		compare.offset,
		compare.exact,
		lsp_scores,
		compare.score,
		compare.recently_used,
		compare.locality,
		require("cmp-under-comparator").under,
		compare.kind,
		compare.length,
		compare.order,
	}
	if _G.use_copilot then
		table.insert(comparators, 1, require("copilot_cmp.comparators").prioritize)
	end
	return comparators
end

return M
