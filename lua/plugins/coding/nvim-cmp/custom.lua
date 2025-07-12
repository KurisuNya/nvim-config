local M = {}

M.mapping = function(keymaps)
	local cmp = require("cmp")

	local select = function(actions)
		return function(fallback)
			for _, action in ipairs(actions) do
				if action.cond == nil or action.cond() then
					action.action()
					return
				end
			end
			fallback()
		end
	end

	local function confirm(actions)
		return function(fallback)
			if cmp.visible() then
				for _, action in ipairs(actions) do
					if action.cond == nil or action.cond() then
						action.action()
						return
					end
				end
			end
			fallback()
		end
	end

	local map = {
		select_next = function(spec)
			return cmp.mapping(select(spec.actions), spec.mode)
		end,
		select_prev = function(spec)
			return cmp.mapping(select(spec.actions), spec.mode)
		end,
		confirm = function(spec)
			return cmp.mapping(confirm(spec.actions), spec.mode)
		end,
		scroll_docs_up = function(spec)
			return cmp.mapping.scroll_docs(-4)
		end,
		scroll_docs_down = function(spec)
			return cmp.mapping.scroll_docs(4)
		end,
	}

	local list = {}
	for cmd, spec in pairs(keymaps) do
		local keys = type(spec.key) == "table" and spec.key or { spec.key }
		for _, key in ipairs(keys) do
			list[key] = map[cmd](spec)
		end
	end
	return list
end

M.format = function(opts)
	return function(entry, vim_item)
		-- kind string
		local cmp_icons = vim.tbl_deep_extend("force", Icons.symbols, Icons.cmp)
		vim_item.kind = string.format(" %s %s ", cmp_icons[vim_item.kind] or Icons.cmp.undefined, vim_item.kind or "")
		-- menu string
		if opts.menu ~= nil then
			vim_item.menu = opts.menu[entry.source.name] or "[UDEF]"
		end
		if opts.label_maxwidth == nil then
			return vim_item
		end
		-- format abbr and menu
		local ellipsis_char = opts.ellipsis_char or "..."
		local abbr = vim_item.abbr
		local truncated_abbr = vim.fn.strcharpart(abbr, 0, opts.label_maxwidth)
		if truncated_abbr ~= abbr then
			vim_item.abbr = truncated_abbr .. ellipsis_char
		end
		local menu = vim_item.menu
		if menu ~= nil then
			local truncated_menu = vim.fn.strcharpart(menu, 0, opts.menu_maxwidth)
			if truncated_menu ~= menu then
				vim_item.menu = truncated_menu .. ellipsis_char
			end
		end
		return vim_item
	end
end

return M
