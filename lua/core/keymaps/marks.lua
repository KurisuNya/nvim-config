local M = {}
M.keys = {
	{
		"<leader>md",
		"<Plug>(Marks-deleteline)",
		desc = "Mark Delete Line",
		mode = "n",
	},
	{
		"<leader>mD",
		"<Plug>(Marks-deletebuf)",
		desc = "Mark Delete Buffer",
		mode = "n",
	},
	{
		"<leader>mp",
		"<Plug>(Marks-preview)",
		desc = "Mark Preview",
		mode = "n",
	},
	{
		"mm",
		"<Plug>(Marks-toggle)",
		desc = "Mark Toggle",
		mode = "n",
	},
}
return M
