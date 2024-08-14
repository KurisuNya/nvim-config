---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	require("nvim-ts-autotag").setup({
		opts = {
			enable_rename = true,
			enable_close = true,
			enable_close_on_slash = false,
		},
	})
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"comment",
			"cpp",
			"css",
			"diff",
			"gitcommit",
			"gitignore",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"matlab",
			"ninja",
			"php",
			"python",
			"query",
			"regex",
			"rst",
			"rust",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
			"yuck",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
			disable = { "python" },
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select function Outer" },
					["if"] = { query = "@function.inner", desc = "Select function Inner" },
					["ac"] = { query = "@class.outer", desc = "Select class Outer" },
					["ic"] = { query = "@class.inner", desc = "Select class Inner" },
				},
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@function.inner"] = "V",
					["@class.outer"] = "<c-v>",
				},
			},
			move = {
				enable = true,
				goto_next_start = {
					["]f"] = { query = "@function.outer", desc = "Next Function Start" },
					["]c"] = { query = "@class.outer", desc = "Next Class Start" },
				},
				goto_next_end = {
					["]F"] = { query = "@function.outer", desc = "Next Function End" },
					["]C"] = { query = "@class.outer", desc = "Next Class End" },
				},
				goto_previous_start = {
					["[f"] = { query = "@function.outer", desc = "Previous Function Start" },
					["[c"] = { query = "@class.outer", desc = "Previous Class Start" },
				},
				goto_previous_end = {
					["[F"] = { query = "@function.outer", desc = "Previous Function End" },
					["[C"] = { query = "@class.outer", desc = "Previous Class End" },
				},
			},
		},
	})
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
end
return M
