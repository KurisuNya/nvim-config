local M = {}
M.keys = {
	{
		"<leader>md",
		desc = "Mark Delete Line",
		mode = "n",
	},
	{
		"<leader>mD",
		desc = "Mark Delete Buffer",
		mode = "n",
	},
	{
		"<leader>mp",
		desc = "Mark Preview",
		mode = "n",
	},
	{
		"mm",
		desc = "Mark Toggle",
		mode = "n",
	},
	{
		"]'",
		desc = "Next Mark",
		mode = "n",
	},
	{
		"['",
		desc = "Previous Mark",
		mode = "n",
	},
}
M.keymap_list = {
	delete_line = "<leader>md",
	delete_buf = "<leader>mD",
	preview = "<leader>mp",
	toggle = "mm",
	next = "]'",
	prev = "['",
}
return M
