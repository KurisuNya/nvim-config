local M = {}
M.keys = {
	{
		"<A-w>",
		"<Plug>CamelCaseMotion_w",
		desc = "CamelMove w",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<A-b>",
		"<Plug>CamelCaseMotion_b",
		desc = "CamelMove b",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<A-e>",
		"<Plug>CamelCaseMotion_e",
		desc = "CamelMove e",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
