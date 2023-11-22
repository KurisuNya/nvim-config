local M = {}
M.nvim_dap_keys = {
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
M.goto_breakpoints_keys = function()
	local goto_breakpoints = require("goto-breakpoints")
	vim.keymap.set("n", "]b", goto_breakpoints.next, {
		noremap = true,
		silent = true,
		desc = "Breakpoints Next",
	})
	vim.keymap.set("n", "[b", goto_breakpoints.prev, {
		noremap = true,
		silent = true,
		desc = "Breakpoints Previous",
	})
end
M.persistent_breakpoints_keys = function()
	local breakpoints = require("persistent-breakpoints.api")
	vim.keymap.set("n", "<Leader>b", breakpoints.toggle_breakpoint, {
		noremap = true,
		silent = true,
		desc = "Breakpoints Toggle",
	})
	vim.keymap.set("n", "<Leader>B", breakpoints.clear_all_breakpoints, {
		noremap = true,
		silent = true,
		desc = "Breakpoints Clear All",
	})
end
return M
