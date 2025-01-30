---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	vim.opt.pumheight = 15 -- cmp number
	vim.opt.completeopt = "menu,menuone,noselect"

	local cmp = require("cmp")
	local custom = require("plugins.coding.nvim-cmp-custom")
	local keymaps = require("keymaps.plugins.nvim-cmp").keymaps

	local opts = {
		preselect = cmp.PreselectMode.Item,
		experimental = { ghost_text = true },
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		sources = cmp.config.sources(custom.get_normal_sources()),
		mapping = cmp.mapping.preset.insert(custom.get_keymap_list(keymaps)),
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = custom.format({
				label_maxwidth = 25,
				menu_maxwidth = 20,
				ellipsis_char = "",
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
		performance = {
			debounce = 20,
			throttle = 10,
			fetching_timeout = 500,
			filtering_context_budget = 3,
			confirm_resolve_timeout = 80,
			async_budget = 1,
			max_view_entries = 200,
		},
	}
	if KurisuNya.utils.plugin_exist("LuaSnip") then
		opts.snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		}
	end
	cmp.setup(opts)
	cmp.setup.filetype({ "markdown" }, {
		sources = custom.get_markdown_sources(),
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
	cmp.setup.filetype({ "TelescopePrompt" }, { sources = {} })
end
return M
