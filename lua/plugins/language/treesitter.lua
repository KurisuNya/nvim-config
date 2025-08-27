---@diagnostic disable: missing-fields
PluginVars.treesitter_ensure_installed = {
	"bash",
	"regex",
	"markdown",
	"markdown_inline",
	"gitcommit",
	"gitignore",
	"gitattributes",
}

local M = {
	"nvim-treesitter/nvim-treesitter",
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	build = ":TSUpdate",
	event = "VeryLazy",
	lazy = vim.fn.argc(-1) == 0,
}

M.dependencies = {
	{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
}

M.init = function(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

M.config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = Utils.tbl_filter_same(PluginVars.treesitter_ensure_installed),
		highlight = { enable = true, disable = { "latex" } },
		indent = { enable = true, disable = { "python" } },
	})
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
