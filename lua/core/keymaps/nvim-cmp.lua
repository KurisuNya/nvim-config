local cmp = require("cmp")
local luasnip = require("luasnip")
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local M = {}
M.keymap_list = {
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),
	["<CR>"] = cmp.mapping(function(fallback)
		if not cmp.visible() then
			fallback()
		elseif cmp.get_selected_entry() then
			cmp.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			})
		elseif has_words_before() then
			cmp.abort()
		else
			fallback()
		end
	end, { "i" }),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
}
return M
