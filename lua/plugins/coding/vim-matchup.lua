return {
	"andymass/vim-matchup",
	init = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
	opts = { treesitter = { stopline = 500 } },
	event = "VeryLazy",
}
