----------------
--  nvim-cmp  --
----------------
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end
local fast_snip_status, fast_snip = pcall(require, "fast-snip")
if not fast_snip_status then
	return
end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("x", "<leader>gs", function()
	fast_snip.new_snippet_or_add_placeholder()
	vim.cmd("normal !u")
end, opts)
keymap.set("n", "<leader>gs", fast_snip.finalize_snippet, opts)

local M = {
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm({ select = false }),
}
return M
