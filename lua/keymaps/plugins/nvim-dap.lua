local M = {}
M.keys = {
	{
		"<leader>dc",
		"<Cmd>DapContinue<CR>",
		desc = "Dap Continue",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<leader>dt",
		"<Cmd>DapTerminate<CR>",
		desc = "Dap Terminate",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<leader>]",
		"<Cmd>DapStepOver<CR>",
		desc = "Dap StepOver",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<leader>}",
		"<Cmd>DapStepIn<CR>",
		desc = "Dap StepIn",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"<leader>{",
		"<Cmd>DapStepOut<CR>",
		desc = "Dap StepOut",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
