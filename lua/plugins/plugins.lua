return {
	----------------
	-- dependence --
	----------------
	{ "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "kkharji/sqlite.lua", event = "VeryLazy" },
	{ "kevinhwang91/promise-async", event = "VeryLazy" },
	{ "SmiteshP/nvim-navic", event = "VeryLazy" },

	--------
	-- ui --
	--------
	-- theme
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
	-- utils
	{ "MunifTanjim/nui.nvim", event = "VeryLazy" },
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {
			color_icons = true,
			default = true,
			strict = true,
		},
	},
	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	-- bar and line
	{ "romgrk/barbar.nvim", event = "VeryLazy" },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	-- notify
	{ "KurisuNya/noice.nvim", event = "VeryLazy" },
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			render = "wrapped-compact",
			stages = "static",
			timeout = 4000,
		},
	},
	-- better ui
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{ "karb94/neoscroll.nvim", event = "VeryLazy", opts = {} },
	{
		"norcalli/nvim-colorizer.lua",
		-- event = "VeryLazy",
		init = function()
			vim.opt.termguicolors = true
		end,
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"machakann/vim-highlightedyank",
		event = "VeryLazy",
		init = function()
			vim.g.highlightedyank_highlight_duration = 400
			vim.b.highlightedyank_highlight_duration = 400
		end,
	},
	{ "nacro90/numb.nvim", event = "VeryLazy", opts = {} },
	{ "kevinhwang91/nvim-ufo", event = "VeryLazy" },
	{ "nvimdev/hlsearch.nvim", event = "BufRead", opts = {} },

	---------
	-- cmp --
	---------
	{ "abecodes/tabout.nvim", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", event = "VeryLazy" },
	-- snip
	{ "L3MON4D3/LuaSnip", event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets", event = "VeryLazy" },
	{ "KurisuNya/fast-snip", event = "VeryLazy" },
	-- cmp
	{ "hrsh7th/nvim-cmp", event = "VeryLazy" },
	{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
	{ "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
	{ "hrsh7th/cmp-buffer", event = "VeryLazy" },
	{ "FelipeLema/cmp-async-path", event = "VeryLazy" },
	{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
	{ "kdheepak/cmp-latex-symbols", event = "VeryLazy" },
	{ "lukas-reineke/cmp-under-comparator", event = "VeryLazy" },

	---------
	-- lsp --
	---------
	-- treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "VeryLazy" },
	{ "p00f/nvim-ts-rainbow", event = "VeryLazy" },
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- mason
	{ "williamboman/mason.nvim", event = "VeryLazy", opts = {} },
	{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
	{ "jayp0521/mason-null-ls.nvim", event = "VeryLazy" },
	{ "jay-babu/mason-nvim-dap.nvim", event = "VeryLazy" },
	-- lsp
	{ "neovim/nvim-lspconfig", event = "VeryLazy" },
	{ "glepnir/lspsaga.nvim", event = "VeryLazy", commit = "283a3fc" },
	{ "ray-x/lsp_signature.nvim", event = "VeryLazy" },
	{ "lvimuser/lsp-inlayhints.nvim", event = "VeryLazy" },
	{ "nvimtools/none-ls.nvim", event = "VeryLazy" },
	{ "folke/neodev.nvim", event = "VeryLazy" },
	{ "mfussenegger/nvim-jdtls", ft = "java" },
	{ "folke/trouble.nvim", event = "VeryLazy", opts = {} },
	{ "SmiteshP/nvim-navbuddy", event = "VeryLazy" },
	-- dap
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy", opts = {} },
	{
		"Weissle/persistent-breakpoints.nvim",
		event = "VeryLazy",
		opts = {
			load_breakpoints_event = { "BufReadPost" },
		},
	},
	{ "ofirgall/goto-breakpoints.nvim", event = "VeryLazy" },

	----------
	-- tool --
	----------
	-- dashboard and explorer
	{ "goolord/alpha-nvim", event = "VeryLazy" },
	{ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", event = "VeryLazy" },
	-- session
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		init = function()
			require("project_nvim").setup({
				manual_mode = true,
			})
		end,
	},
	{ "folke/persistence.nvim", event = "BufReadPre", opts = {} },

	-- git
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
		},
	},
	{ "KurisuNya/vgit.nvim", event = "VeryLazy", opts = {} },
	-- telescope
	{ "nvim-telescope/telescope.nvim", event = "VeryLazy" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		event = "VeryLazy",
	},
	{ "debugloop/telescope-undo.nvim", event = "VeryLazy" },
	{ "nvim-telescope/telescope-frecency.nvim", event = "VeryLazy" },
	-- operations
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{ "nguyenvukhang/nvim-toggler", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "phaazon/hop.nvim", event = "VeryLazy", opts = {}, branch = "v2" },
	{ "Weissle/easy-action", event = "VeryLazy", opts = {} },
	{ "bkad/CamelCaseMotion", event = "VeryLazy" },
	{
		"dhruvasagar/vim-table-mode",
		event = "VeryLazy",
		init = function()
			vim.g.table_mode_map_prefix = "<Bar>"
			vim.g.table_mode_toggle_map = "<Bar>"
			vim.g.table_mode_tableize_map = "<leader><Bar>"
			vim.g.table_mode_corner = "|"
		end,
	},
	{ "Darazaki/indent-o-matic", event = "BufRead", opts = {} },
	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "KurisuNya/nvim-picgo", event = "VeryLazy", opts = {} },
	-- linux
	{ "h-hg/fcitx.nvim", event = "VeryLazy" },
	{
		"lambdalisue/suda.vim",
		event = "VeryLazy",
		init = function()
			vim.g.suda_smart_edit = 1
		end,
	},
	-- other
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 1000
		end,
		opts = {},
	},
	{ "nvim-pack/nvim-spectre", event = "VeryLazy" },
	{
		"ziontee113/icon-picker.nvim",
		event = "VeryLazy",
		opts = {
			disable_legacy_commands = true,
		},
	},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		event = "VeryLazy",
		opts = {
			display = {
				"TempFloatingWindow", --# display results in a floating window
			},
			borders = "rounded",
		},
	},
}
