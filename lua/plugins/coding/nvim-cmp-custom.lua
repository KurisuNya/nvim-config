local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local function to_table(value)
	return type(value) ~= "table" and { value } or value
end

local M = {}
M.get_keymap_list = function(keymaps)
	local cmp = require("cmp")
	local neotab = require("neotab")

	local function select_next_item(fallback)
		if cmp.visible() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
		else
			neotab.tabout()
		end
	end
	local function select_prev_item(fallback)
		if cmp.visible() then
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
		else
			fallback()
		end
	end

	if KurisuNya.utils.plugin_exist("LuaSnip") then
		local luasnip = require("luasnip")
		select_next_item = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				neotab.tabout()
			end
		end
		select_prev_item = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end
	end

	local function confirm(fallback)
		if not cmp.visible() then
			fallback()
			return
		end
		if cmp.get_selected_entry() then
			cmp.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			})
		elseif has_words_before() then
			cmp.abort()
		else
			fallback()
		end
	end

	return {
		[keymaps.select_next] = cmp.mapping(select_next_item, { "i", "s" }),
		[keymaps.select_prev] = cmp.mapping(select_prev_item, { "i", "s" }),
		[keymaps.confirm] = cmp.mapping(confirm, { "i" }),
		[keymaps.scroll_docs_up] = cmp.mapping.scroll_docs(-4),
		[keymaps.scroll_docs_down] = cmp.mapping.scroll_docs(4),
	}
end

M.format = function(opts)
	local icons = require("plugins.ui.icons")
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

M.get_normal_sources = function()
	local sources = {
		{ name = "async_path" },
		{ name = "nvim_lsp", max_item_count = 350 },
		{ name = "buffer", max_item_count = 5 },
	}
	if KurisuNya.utils.plugin_exist("LuaSnip") then
		table.insert(sources, 3, { name = "luasnip" })
	end
	if KurisuNya.config.use_copilot then
		table.insert(sources, { name = "copilot" })
	end
	if KurisuNya.utils.plugin_exist("lazydev.nvim") then
		table.insert(sources, { name = "lazydev", group_index = 0 })
	end
	return sources
end

M.get_markdown_sources = function()
	local sources = {
		{ name = "async_path" },
		{ name = "buffer" },
		{ name = "latex_symbols", option = { strategy = 2 } },
	}
	if KurisuNya.config.use_copilot then
		table.insert(sources, { name = "copilot" })
	end
	return sources
end

return M
