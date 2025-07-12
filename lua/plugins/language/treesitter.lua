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
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
}

M.init = function(plugin)
	require("lazy.core.loader").add_to_rtp(plugin)
	require("nvim-treesitter.query_predicates")
end

local inc_selection = {
	init_selection = "<C-l>",
	node_incremental = "<C-l>",
	scope_incremental = false,
	node_decremental = "<C-h>",
}
local textobjects = {
	goto_next_start = { ["<C-j>"] = "@parameter.inner" },
	goto_previous_start = { ["<C-k>"] = "@parameter.inner" },
}
M.config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = Utils.tbl_filter_same(PluginVars.treesitter_ensure_installed),
		highlight = { enable = true, disable = { "latex" } },
		indent = { enable = true, disable = { "python" } },
		incremental_selection = { enable = true, keymaps = inc_selection },
		textobjects = { move = vim.tbl_deep_extend("force", { enable = true }, textobjects) },
	})
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
