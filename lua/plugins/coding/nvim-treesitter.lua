---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	local module = require("keymaps.plugins.nvim-treesitter")
	require("nvim-treesitter.configs").setup({
		ensure_installed = KurisuNya.config.treesitter_ensure_installed,
		highlight = { enable = true },
		indent = { enable = true, disable = { "python" } },
		incremental_selection = {
			enable = true,
			keymaps = module.incremental_selection.keymaps,
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = module.textobjects.goto_next_start,
				goto_next_end = module.textobjects.goto_next_end,
				goto_previous_start = module.textobjects.goto_previous_start,
				goto_previous_end = module.textobjects.goto_previous_end,
			},
		},
	})
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 99
	vim.g.matchup_matchparen_offscreen = { method = "popup" }
end
return M
