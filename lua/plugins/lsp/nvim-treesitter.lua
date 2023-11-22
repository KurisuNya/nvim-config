---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	require("nvim-ts-autotag").setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"comment",
			"cpp",
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
			"php",
			"python",
			"query",
			"regex",
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
		matchup = {
			enable = true,
		},
	})
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
end
return M
