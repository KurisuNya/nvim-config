local M = {
	"iguanacucumber/magazine.nvim",
	name = "nvim-cmp",
	event = "VeryLazy",
}

M.dependencies = {
	{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
	{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
	{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
	{ url = "https://codeberg.org/FelipeLema/cmp-async-path.git" },
	"saadparwaiz1/cmp_luasnip",
	{ "kawre/neotab.nvim", opts = { tabkey = "", behavior = "closing" }, event = "VeryLazy" },
}

local copilot_plugins = {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			copilot_model = "gpt-4o-copilot",
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = { markdown = true, yaml = true, help = true },
		},
		init = function()
			PluginVars.insert(PluginVars.lualine_hidden_lsp, "copilot")
		end,
	},
	{ "KurisuNya/copilot-cmp", opts = {} },
}
if Config.enable_copilot then
	M.dependencies = vim.list_extend(M.dependencies, copilot_plugins)
end

M.opts = function()
	local cfg = {
		max_item_count = 15,
		ghost_text = true,
		performance = {
			debounce = 20,
			throttle = 10,
			fetching_timeout = 1000,
			filtering_context_budget = 3,
			confirm_resolve_timeout = 80,
			async_budget = 1,
			max_view_entries = 200,
		},
		sources = {
			normal = {
				{ name = "nvim_lsp" },
				{ name = "async_path" },
				{ name = "buffer" },
			},
			search = {
				{ name = "buffer" },
			},
			command = {
				{ name = "async_path" },
				{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
			},
		},
		format = {
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
		},
	}
	if Utils.plugin_exists("LuaSnip") then
		table.insert(cfg.sources.normal, 3, { name = "luasnip" })
		cfg.snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		}
	end
	if Utils.plugin_exists("copilot-cmp") then
		table.insert(cfg.sources.normal, { name = "copilot" })
	end
	return cfg
end

local get_normal_keymaps = function()
	local cmp = require("cmp")
	local neotab = require("neotab")
	local keymaps = {
		select_next = {
			key = "<Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_next_item },
				{ action = neotab.tabout },
			},
			mode = { "i", "s" },
		},
		select_prev = {
			key = "<S-Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_prev_item },
			},
			mode = { "i", "s" },
		},
		confirm = {
			key = "<CR>",
			actions = {
				{
					cond = cmp.get_selected_entry,
					action = function()
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					end,
				},
				{ action = cmp.abort },
			},
			mode = { "i" },
		},
		scroll_docs_up = { key = "<C-u>" },
		scroll_docs_down = { key = "<C-d>" },
	}

	if Utils.plugin_exists("LuaSnip") then
		local luasnip = require("luasnip")
		local next = { cond = luasnip.expand_or_jumpable, action = luasnip.expand_or_jump }
		local prev = {
			cond = function()
				return luasnip.jumpable(-1)
			end,
			action = function()
				luasnip.jump(-1)
			end,
		}
		table.insert(keymaps.select_next.actions, 2, next)
		table.insert(keymaps.select_prev.actions, 2, prev)
	end

	return keymaps
end

local get_search_keymap = function()
	local cmp = require("cmp")
	return {
		select_next = {
			key = "<Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_next_item },
				{ action = cmp.complete },
			},
			mode = { "c" },
		},
		select_prev = {
			key = "<S-Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_prev_item },
				{ action = cmp.complete },
			},
			mode = { "c" },
		},
	}
end

local get_command_keymap = function()
	local cmp = require("cmp")
	return {
		select_next = {
			key = "<Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_next_item },
				{ action = cmp.complete },
			},
			mode = { "c" },
		},
		select_prev = {
			key = "<S-Tab>",
			actions = {
				{ cond = cmp.visible, action = cmp.select_prev_item },
				{ action = cmp.complete },
			},
			mode = { "c" },
		},
		confirm = {
			key = "<CR>",
			actions = {
				{
					cond = cmp.get_selected_entry,
					action = function()
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					end,
				},
			},
			mode = { "c" },
		},
	}
end

M.config = function(_, cfg)
	vim.opt.pumheight = cfg.max_item_count
	vim.opt.completeopt = "menu,menuone,noselect"

	local cmp = require("cmp")
	local custom = require("plugins.coding.nvim-cmp.custom")

	local opts = {
		preselect = cmp.PreselectMode.Item,
		experimental = { ghost_text = cfg.ghost_text },
		window = {
			completion = cmp.config.window.bordered({ border = Config.border_style }),
			documentation = cmp.config.window.bordered({ border = Config.border_style }),
		},
		sources = cmp.config.sources(cfg.sources.normal),
		mapping = cmp.mapping.preset.insert(custom.mapping(get_normal_keymaps())),
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = custom.format(cfg.format),
		},
		performance = cfg.performance,
		snippet = cfg.snippet,
	}
	cmp.setup(opts)
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(custom.mapping(get_search_keymap())),
		sources = cmp.config.sources(cfg.sources.search),
	})
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(custom.mapping(get_command_keymap())),
		sources = cmp.config.sources(cfg.sources.command),
	})
end

return M
