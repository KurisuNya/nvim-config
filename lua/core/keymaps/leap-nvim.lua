local M = {}
M.keys = {
	{
		"s",
		"<Plug>(leap-forward)",
		mode = { "n", "x", "o" },
		noremap = true,
		silent = true,
	},
	{
		"S",
		"<Plug>(leap-backward)",
		mode = { "n", "x", "o" },
		noremap = true,
		silent = true,
	},
}
return M
