--------------------
--  tool-plugins  --
--------------------
local M = {

	-- dashboard and explorer
	{
		"goolord/alpha-nvim",
		config = require("plugins.tool.alpha-nvim").config,
		event = "VimEnter",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = require("core.keymaps.neo-tree").keys,
		config = require("plugins.tool.neo-tree").config,
		branch = "v3.x",
		event = "VeryLazy",
	},

	-- project
	{
		"gnikdroy/projections.nvim",
		branch = "pre_release",
		init = require("plugins.tool.projections-nvim").init,
		keys = require("core.keymaps.projections-nvim").keys,
		config = require("plugins.tool.projections-nvim").config,
		event = "VeryLazy",
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		keys = require("core.keymaps.telescope").keys,
		config = require("plugins.tool.telescope").config,
		dependencies = {
			"debugloop/telescope-undo.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
			.. "cmake --build build --config Release && "
			.. "cmake --install build --prefix build",
	},
	{ "debugloop/telescope-undo.nvim" },

	-- git
	{
		"lewis6991/gitsigns.nvim",
		keys = require("core.keymaps.gitsigns").keys,
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
		keys = require("core.keymaps.nvim-tinygit").keys,
		ft = { "gitrebase", "gitcommit" },
	},
	{
		"sindrets/diffview.nvim",
		keys = require("core.keymaps.diffview").keys,
		config = require("plugins.tool.diffview").config,
		event = "VeryLazy",
	},

	-- operations
	{
		"ggandor/leap.nvim",
		keys = require("core.keymaps.leap-nvim").keys,
		event = "VeryLazy",
	},
	{ "ggandor/leap-spooky.nvim", opts = {}, event = "VeryLazy" },
	{
		"nguyenvukhang/nvim-toggler",
		keys = require("core.keymaps.nvim-toggler").keys,
		config = require("plugins.tool.nvim-toggler").config,
		event = "VeryLazy",
	},
	{ "Darazaki/indent-o-matic", opts = {}, event = "BufRead" },
	{ "numToStr/Comment.nvim", opts = {}, event = "VeryLazy" },
	{ "kylechui/nvim-surround", opts = {}, event = "VeryLazy" },
	{
		"bkad/CamelCaseMotion",
		keys = require("core.keymaps.camelcase").keys,
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		keys = require("core.keymaps.todo-comment").keys,
		opts = {},
		event = "VeryLazy",
	},

	-- markdown
	{
		"iamcco/markdown-preview.nvim",
		keys = require("core.keymaps.markdown-preview").keys,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
	{
		"KurisuNya/nvim-picgo",
		opts = { auto_paste = true },
		ft = "markdown",
	},
	{
		"KurisuNya/clipboard-image.nvim",
		keys = require("core.keymaps.clipboard-image").keys,
		opts = {
			markdown = {
				img_dir = "~/Pictures/Markdown",
				img_dir_txt = "~/Pictures/Markdown",
				paste_handler = function(affix, path_txt) end,
				img_handler = function(img)
					require("nvim-picgo").upload_imagefile({ path = img.path })
				end,
			},
		},
		ft = "markdown",
	},
	{
		"dhruvasagar/vim-table-mode",
		keys = {
			{
				"<leader>|",
				desc = "Tableize",
				mode = "n",
			},
		},
		init = function()
			vim.g.table_mode_map_prefix = "<Bar>"
			vim.g.table_mode_toggle_map = "<Bar>"
			vim.g.table_mode_tableize_map = "<leader><Bar>"
			vim.g.table_mode_corner = "|"
		end,
		ft = "markdown",
	},

	-- other
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = require("core.keymaps.toggleterm").keys,
		config = require("plugins.tool.toggleterm").config,
		event = "VeryLazy",
	},
	{
		"folke/which-key.nvim",
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 1000
		end,
		opts = {},
		event = "VeryLazy",
	},
	{
		"nvim-pack/nvim-spectre",
		keys = require("core.keymaps.nvim-spectre").keys,
		config = require("plugins.tool.nvim-spectre").config,
		event = "VeryLazy",
	},
	{ "stevearc/stickybuf.nvim", opts = {}, event = "VeryLazy" },
	{
		"ziontee113/icon-picker.nvim",
		keys = require("core.keymaps.icon-picker").keys,
		opts = {
			disable_legacy_commands = true,
		},
		event = "VeryLazy",
	},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		opts = {
			display = {
				"TempFloatingWindow", --# display results in a floating window
			},
			borders = "rounded",
		},
		event = "VeryLazy",
	},
	{
		"LunarVim/bigfile.nvim",
		config = require("plugins.tool.bigfile").config,
		event = "VeryLazy",
	},
}

if vim.loop.os_uname().sysname == "Linux" then
	local linux_plugins = {
		-- linux
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
