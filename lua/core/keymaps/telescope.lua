local M = {}
M.keys = {
	{
		"<leader>ff",
		"<Cmd>Telescope find_files<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find File",
	},
	{
		"<leader>fr",
		"<Cmd>Telescope oldfiles<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find Recent File",
	},
	{
		"<leader>fs",
		"<Cmd>Telescope live_grep<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find String",
	},
	{
		"<leader>fc",
		"<Cmd>Telescope git_commits<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find Commit",
	},
	{
		"<leader>fb",
		"<Cmd>Telescope git_branches<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Find Branch",
	},
	{
		"<leader>u",
		"<Cmd>Telescope undo<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Undo Tree",
	},
}

M.telescope_undo = { restore = "<CR>" }
return M
