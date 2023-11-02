---@diagnostic disable: missing-fields
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end
local cmp_under_comparator_status, cmp_under_comparator = pcall(require, "cmp-under-comparator")
if not cmp_under_comparator_status then
	return
end
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end
require("luasnip.loaders.from_vscode").lazy_load()
local map_list = require("core.keymaps").nvim_cmp
vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	preselect = cmp.PreselectMode.Item,
	experimental = {
		ghost_text = true,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		[map_list.select_prev_item] = cmp.mapping.select_prev_item(),
		[map_list.select_next_item] = cmp.mapping.select_next_item(),
		[map_list.scroll_docs_up] = cmp.mapping.scroll_docs(-4),
		[map_list.scroll_docs_down] = cmp.mapping.scroll_docs(4),
		[map_list.complete] = cmp.mapping.complete(),
		[map_list.abort] = cmp.mapping.abort(),
		[map_list.confirm] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "async_path", priority = 6 },
		{ name = "luasnip", priority = 5 },
		{ name = "nvim_lsp", priority = 4 },
		{ name = "nvim_lua", priority = 3 },
		{ name = "buffer", priority = 2, max_item_count = 5 },
		{
			name = "spell",
			priority = 1,
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
		},
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 30,
			ellipsis_char = "...",
		}),
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp_under_comparator.under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "async_path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

cmp.setup.filetype({ "TelescopePrompt" }, {
	sources = {},
})
cmp.setup.filetype({ "markdown" }, {
	sources = {
		{
			name = "async_path",
			priority = 3,
		},
		{
			name = "spell",
			option = {
				keep_all_entries = false,
				enable_in_context = function()
					return true
				end,
			},
			priority = 2,
		},
		{
			name = "latex_symbols",
			option = {
				strategy = 2,
			},
			priority = 1,
		},
	},
})
