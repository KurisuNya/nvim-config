local cmp = require("cmp")
local luasnip = require("luasnip")
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
		if cmp.visible() then
			if cmp.get_selected_entry() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				})
			else
				cmp.abort()
			end
		else
			fallback()
		end
	end, { "i" }),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
}
return M
