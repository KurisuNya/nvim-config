---@diagnostic disable: missing-fields
local M = {
	-- mason
	{
		"williamboman/mason.nvim",
		config = function()
			local t = {}
			t = vim.list_extend(t, KurisuNya.config.lsp_ensure_installed)
			t = vim.list_extend(t, KurisuNya.config.dap_ensure_installed)
			t = vim.list_extend(t, KurisuNya.config.linter_ensure_installed)
			t = vim.list_extend(t, KurisuNya.config.formatter_ensure_installed)
			require("mason").setup({})
			local mr = require("mason-registry")
			mr.refresh(function()
				for _, tool in ipairs(t) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
		event = "VeryLazy",
	},
	-- lsp client
	{
		"neovim/nvim-lspconfig",
		config = require("plugins.language.lspconfig").config,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		event = "VeryLazy",
	},
	{
		"folke/lazydev.nvim",
		dependencies = { { "Bilal2453/luvit-meta" } },
		opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } },
		ft = "lua",
	},
	{
		"mfussenegger/nvim-jdtls",
		config = require("plugins.language.nvim-jdtls").config,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
		},
		ft = "java",
	},
	{
		"nvimtools/none-ls.nvim",
		config = require("plugins.language.none-ls").config,
		dependencies = { "jayp0521/mason-null-ls.nvim" },
		event = "VeryLazy",
	},
	-- lsp tools
	{
		"nvimdev/lspsaga.nvim",
		config = require("plugins.language.lspsaga").config,
		event = "VeryLazy",
	},
	{
		"KurisuNya/nvim-gtd",
		config = function()
			require("gtd").setup({})
			local keymap = require("keymaps.plugins.gtd").keymaps.goto_definition
			KurisuNya.utils.lsp_keymap_set_by_method("textDocument/definition", keymap)
		end,
		event = "VeryLazy",
	},
	{
		"SmiteshP/nvim-navbuddy",
		config = require("plugins.language.nvim-navbuddy").config,
		dependencies = { "SmiteshP/nvim-navic" },
		event = "VeryLazy",
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		dependencies = {
			{
				"felpafel/inlay-hint.nvim",
				config = function()
					require("inlay-hint").setup()
				end,
			},
		},
		config = function()
			require("inlay-hints").setup()
		end,
		event = "LspAttach",
	},
	-- dap
	{
		"rcarriga/nvim-dap-ui",
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "dap_repl")
			table.insert(KurisuNya.config.close_before_session_filetypes, "dapui_console")
			table.insert(KurisuNya.config.close_before_session_filetypes, "dapui_stacks")
			table.insert(KurisuNya.config.close_before_session_filetypes, "dapui_scopes")
			table.insert(KurisuNya.config.close_before_session_filetypes, "dapui_breakpoints")
		end,
		dependencies = {
			{
				"mfussenegger/nvim-dap",
				keys = require("keymaps.plugins.nvim-dap").keys,
				dependencies = { "jay-babu/mason-nvim-dap.nvim", opts = { handlers = {} } },
			},
			{
				"mfussenegger/nvim-dap-python",
				config = require("plugins.language.nvim-dap-python").config,
			},
		},
		keys = require("keymaps.plugins.nvim-dap-ui").keys,
		config = require("plugins.language.nvim-dap-ui").config,
		event = "VeryLazy",
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		keys = require("keymaps.plugins.persistent-breakpoints-nvim").keys,
		event = "VeryLazy",
		opts = { load_breakpoints_event = { "BufReadPost" } },
	},
	{
		"ofirgall/goto-breakpoints.nvim",
		keys = require("keymaps.plugins.goto-breakpoints-nvim").keys,
	},
	{ "theHamsta/nvim-dap-virtual-text", opts = {}, event = "VeryLazy" },
	-- test
	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-python" },
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "neotest-summary")
		end,
		keys = require("keymaps.plugins.neotest").keys,
		config = require("plugins.language.neotest").config,
		event = "VeryLazy",
	},
	-- misc
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		opts = {
			display = { "TempFloatingWindow" },
			borders = "rounded",
		},
		event = "VeryLazy",
	},
	{
		"linux-cultist/venv-selector.nvim",
		branch = "regexp",
		keys = require("keymaps.plugins.venv-selector-nvim").keys,
		config = require("plugins.language.venv-selector-nvim").config,
		event = "VeryLazy",
	},
	{
		"lervag/vimtex",
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "tectonic"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.maplocalleader = ","
		end,
		event = "VeryLazy",
	},
}
if not KurisuNya.utils.is_windows() then
	local plugins = { { "davidmh/cspell.nvim" } }
	for _, plugin in ipairs(plugins) do
		table.insert(M, plugin)
	end
end
return M
