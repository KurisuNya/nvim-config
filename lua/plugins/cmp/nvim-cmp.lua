---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	vim.opt.pumheight = 15 -- cmp number
	vim.opt.completeopt = "menu,menuone,noselect"
	local cmp = require("cmp")
	local custom = require("plugins.cmp.nvim-cmp-custom")

	-- cmp
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		experimental = { ghost_text = true },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert(require("core.keymaps.nvim-cmp").keymap_list),
		sources = cmp.config.sources(custom.get_sources()),
		sorting = { comparators = custom.get_comparators() },
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = custom.cmp_format({
				label_maxwidth = 25,
				menu_maxwidth = 20,
				ellipsis_char = "",
				menu = {
					buffer = "[BUF]",
					copilot = "[COP]",
					luasnip = "[SNP]",
					cmdline = "[CMD]",
					nvim_lsp = "[LSP]",
					async_path = "[PATH]",
					latex_symbols = "[LTEX]",
				},
				disable_menu_filetype = { "java" },
			}),
		},
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { { name = "buffer" } },
	})
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "async_path" },
			{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
		}),
	})

	cmp.setup.filetype({ "TelescopePrompt" }, {
		sources = {},
	})
	cmp.setup.filetype({ "markdown" }, {
		sources = custom.get_markdown_sources(),
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
