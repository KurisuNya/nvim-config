return { --dependence
	{
		"nvim-lua/plenary.nvim",
		event = "VeryLazy",
	},
	{
		"kkharji/sqlite.lua",
		event = "VeryLazy",
	},
	--theme
	{
		"folke/tokyonight.nvim",
		event = "VeryLazy",
	},
	--ui
	{
		"MunifTanjim/nui.nvim",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
	},
	{
		"onsails/lspkind.nvim",
		event = "VeryLazy",
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
	},
	{
		"arkav/lualine-lsp-progress",
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
	},
	{
		"p00f/nvim-ts-rainbow",
		event = "VeryLazy",
	},
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
	},
	--cmp
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
	},
	{
		"rafamadriz/friendly-snippets",
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
	},
	{
		"lukas-reineke/cmp-under-comparator",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-buffer",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-path",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VeryLazy",
	},
	{
		"f3fora/cmp-spell",
		event = "VeryLazy",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "VeryLazy",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		event = "VeryLazy",
	},
	--lsp
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
	},
	{
		"mfussenegger/nvim-jdtls",
		event = "VeryLazy",
	},
	{
		"jayp0521/mason-null-ls.nvim",
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},
	{
		"glepnir/lspsaga.nvim",
		event = "VeryLazy",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
	},
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
	},
	--tool
	{
		"nguyenvukhang/nvim-toggler",
		event = "VeryLazy",
	},
	{
		"ojroques/nvim-bufdel",
		event = "VeryLazy",
	},
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
	},
	{
		"goolord/alpha-nvim",
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		event = "VeryLazy",
	},
	{
		"debugloop/telescope-undo.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
	},
	{
		"szw/vim-maximizer",
		event = "VeryLazy",
	},
	{
		"machakann/vim-highlightedyank",
		event = "VeryLazy",
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		event = "VeryLazy",
	},
	{
		"nacro90/numb.nvim",
		event = "VeryLazy",
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"max397574/better-escape.nvim",
		event = "VeryLazy",
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		event = "VeryLazy",
	},
	{
		"bkad/CamelCaseMotion",
		event = "VeryLazy",
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
	},
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
	},
	{
		"h-hg/fcitx.nvim",
		event = "VeryLazy",
	},
	{
		"dhruvasagar/vim-table-mode",
		event = "VeryLazy",
	},
	{
		"lambdalisue/suda.vim",
		event = "VeryLazy",
	},
}
