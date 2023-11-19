---@diagnostic disable: missing-fields, inject-field
local M = {}
M.config = function()
	vim.opt.pumheight = 10 -- cmp number
	vim.opt.completeopt = "menu,menuone,noselect"

	local cmp = require("cmp")
	local map_list = require("core.keymaps.nvim-cmp").keymap_list
	local compare = require("cmp.config.compare")
	compare.lsp_scores = function(entry1, entry2)
		local diff
		if entry1.completion_item.score and entry2.completion_item.score then
			diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
		else
			diff = entry2.score - entry1.score
		end
		return (diff < 0)
	end

	-- cmp
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		experimental = {
			ghost_text = true,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(map_list),
		sources = cmp.config.sources({
			{ name = "nvim_lsp", max_item_count = 350 },
			{ name = "luasnip" },
			{ name = "async_path" },
		}, {
			{ name = "buffer", max_item_count = 5 },
		}),
		formatting = {
			format = require("lspkind").cmp_format({
				maxwidth = 30,
				ellipsis_char = "...",
				menu = {
					nvim_lsp = "[LSP]",
					luasnip = "[SNP]",
					buffer = "[BUF]",
					cmdline = "[CMD]",
					async_path = "[PATH]",
					latex_symbols = "[LTEX]",
				},
			}),
		},
		sorting = {
			comparators = {
				compare.offset,
				compare.exact,
				compare.lsp_scores,
				compare.sort_text,
				compare.score,
				compare.recently_used,
				require("cmp-under-comparator").under,
				compare.locality,
				compare.kind,
				compare.length,
				compare.order,
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
			},
			{
				name = "latex_symbols",
				option = {
					strategy = 2,
				},
			},
		},
	})

	-- autopair
	require("nvim-autopairs").setup({
		check_ts = true,
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
			java = false,
		},
	})
	cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

	--tabout
	require("tabout").setup({
		tabouts = {
			{ open = "'", close = "'" },
			{ open = '"', close = '"' },
			{ open = "`", close = "`" },
			{ open = "(", close = ")" },
			{ open = "[", close = "]" },
			{ open = "{", close = "}" },
		},
		ignore_beginning = true,
	})
end
return M
