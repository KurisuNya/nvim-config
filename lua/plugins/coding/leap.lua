local M = {
	url = "https://codeberg.org/andyg/leap.nvim",
	event = "VeryLazy",
}
M.keys = {
	{
		"s",
		"<Plug>(leap-forward)",
		mode = { "n", "x", "o" },
		silent = true,
	},
	{
		"S",
		"<Plug>(leap-backward)",
		mode = { "n", "x", "o" },
		silent = true,
	},
}
return M
