---@diagnostic disable: missing-fields
local M = {
	-- keymaps
	{ "folke/which-key.nvim", opts = { delay = 1000 }, event = "VeryLazy" },
	-- picker
	{
		"nvim-telescope/telescope.nvim",
		keys = require("keymaps.plugins.telescope").keys,
		config = require("plugins.editor.telescope").config,
		dependencies = {
			"debugloop/telescope-undo.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
					.. "cmake --build build --config Release && "
					.. "cmake --install build --prefix build",
			},
		},
		event = "VeryLazy",
	},
	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "neo-tree")
		end,
		keys = require("keymaps.plugins.neo-tree").keys,
		config = require("plugins.editor.neo-tree").config,
		branch = "v3.x",
		event = "VeryLazy",
	},
	-- project manager
	{
		"gnikdroy/projections.nvim",
		branch = "pre_release",
		init = require("plugins.editor.projections-nvim").init,
		keys = require("keymaps.plugins.projections-nvim").keys,
		config = require("plugins.editor.projections-nvim").config,
		event = "VeryLazy",
	},
	-- terminal
	{
		"akinsho/toggleterm.nvim",
		keys = require("keymaps.plugins.toggleterm").keys,
		config = require("plugins.editor.toggleterm").config,
		event = "VeryLazy",
	},
	-- find and replace
	{
		"MagicDuck/grug-far.nvim",
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "grug-far")
		end,
		keys = require("keymaps.plugins.grug-far-nvim").keys,
		config = require("plugins.editor.grug-far-nvim").config,
		cmd = "GrugFar",
	},
	-- git
	{
		"lewis6991/gitsigns.nvim",
		keys = require("keymaps.plugins.gitsigns").keys,
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			current_line_blame = true,
			current_line_blame_formatter = "   <author_time:%Y-%m-%d>, <author> ∙ <summary>",
			preview_config = {
				border = "rounded",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		event = "VeryLazy",
	},
	{
		"chrisgrieser/nvim-tinygit",
		keys = require("keymaps.plugins.nvim-tinygit").keys,
		ft = { "gitrebase", "gitcommit" },
	},
	{
		"sindrets/diffview.nvim",
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "DiffviewFiles")
			table.insert(KurisuNya.config.close_before_session_filetypes, "DiffviewFileHistory")
		end,
		keys = require("keymaps.plugins.diffview").keys,
		config = require("plugins.editor.diffview").config,
		event = "VeryLazy",
	},
	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		keys = require("keymaps.plugins.markdown-preview").keys,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
	-- misc
	{
		"folke/trouble.nvim",
		init = function()
			table.insert(KurisuNya.config.close_before_session_filetypes, "trouble")
		end,
		keys = require("keymaps.plugins.trouble-nvim").keys,
		opts = {},
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		keys = require("keymaps.plugins.todo-comments").keys,
		opts = {},
		event = "VeryLazy",
	},
	{
		"ziontee113/icon-picker.nvim",
		keys = require("keymaps.plugins.icon-picker").keys,
		opts = { disable_legacy_commands = true },
		event = "VeryLazy",
	},
	{
		"machakann/vim-highlightedyank",
		config = function()
			vim.g.highlightedyank_highlight_duration = 400
			vim.b.highlightedyank_highlight_duration = 400
		end,
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = require("plugins.editor.indent-blankline").config,
		event = "VeryLazy",
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = { "*" },
				user_default_options = {
					RRGGBBAA = true,
					AARRGGBB = true,
					tailwind = true,
					names = false,
					always_update = true,
				},
			})
		end,
		event = "VeryLazy",
	},
	{
		"LunarVim/bigfile.nvim",
		config = require("plugins.editor.bigfile").config,
		event = "VeryLazy",
	},
	{ "karb94/neoscroll.nvim", opts = {}, event = "VeryLazy" },
	{ "nacro90/numb.nvim", opts = {}, event = "VeryLazy" },
	{ "nvimdev/hlsearch.nvim", opts = {}, event = "VeryLazy" },
	{ "RRethy/vim-illuminate", event = "VeryLazy" },
	{ "Darazaki/indent-o-matic", opts = {}, event = "BufRead" },
}
-- linux
if KurisuNya.utils.is_linux() then
	local linux_plugins = {
		{ "h-hg/fcitx.nvim", event = "VeryLazy" },
		{
			"lambdalisue/suda.vim",
			init = function()
				vim.g.suda_smart_edit = 1
			end,
			event = "VeryLazy",
		},
	}
	for _, plugin in ipairs(linux_plugins) do
		table.insert(M, plugin)
	end
end
return M
