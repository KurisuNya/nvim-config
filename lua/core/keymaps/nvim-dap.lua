----------------
--  nvim-dap  --
----------------
local nvim_dap_status, nvim_dap = pcall(require, "dap")
if not nvim_dap_status then
	return
end
local goto_breakpoints_status, goto_breakpoints = pcall(require, "goto-breakpoints")
if not goto_breakpoints_status then
	return
end

local keymap = vim.keymap
local opts = { noremap = true, silent = false }
keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", opts)
keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>", opts)
keymap.set("n", "<leader>]", "<cmd>DapStepOver<cr>", opts)
keymap.set("n", "<leader>}", "<cmd>DapStepIn<cr>", opts)
keymap.set("n", "<Leader>{", "<cmd>DapStepOut<cr>", opts)
keymap.set("n", "<Leader>b", "<cmd>DapToggleBreakpoint<cr>", opts)
keymap.set("n", "<Leader>B", function()
	nvim_dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opts)
keymap.set("n", "]]", goto_breakpoints.next, opts)
keymap.set("n", "[[", goto_breakpoints.prev, opts)
