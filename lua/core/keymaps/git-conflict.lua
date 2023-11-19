local M = {}
M.keys = {
	{
		"<leader>cl",
		"<Cmd>GitConflictListQf<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Conflict List",
	},
	{
		"<leader>co",
		mode = "n",
		desc = "Conflict Choose Ours",
	},
	{
		"<leader>ct",
		mode = "n",
		desc = "Conflict Choose Theirs",
	},
	{
		"<leader>cb",
		mode = "n",
		desc = "Conflict Choose Both",
	},
	{
		"<leader>c0",
		mode = "n",
		desc = "Conflict Choose None",
	},
	{
		"]c",
		mode = "n",
		desc = "Next Conflict",
	},
	{
		"[c",
		mode = "n",
		desc = "Previous Conflict",
	},
}

M.keymap_list = {
	ours = "<leader>co",
	theirs = "<leader>ct",
	both = "<leader>cb",
	none = "<leader>c0",
	next = "]c",
	prev = "[c",
}
return M
