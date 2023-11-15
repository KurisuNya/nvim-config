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
local breakpoints_status, breakpoints = pcall(require, "persistent-breakpoints.api")
if not breakpoints_status then
	return
end

local keymap = vim.keymap
local opts = { noremap = true, silent = false }
keymap.set("n", "<leader>dc", "<Cmd>DapContinue<CR>", opts)
keymap.set("n", "<leader>dt", "<Cmd>DapTerminate<CR>", opts)
keymap.set("n", "<leader>]", "<Cmd>DapStepOver<CR>", opts)
keymap.set("n", "<leader>}", "<Cmd>DapStepIn<CR>", opts)
keymap.set("n", "<Leader>{", "<Cmd>DapStepOut<CR>", opts)
keymap.set("n", "<Leader>b", breakpoints.toggle_breakpoint, opts)
keymap.set("n", "<Leader>B", breakpoints.clear_all_breakpoints, opts)
keymap.set("n", "]]", goto_breakpoints.next, opts)
keymap.set("n", "[[", goto_breakpoints.prev, opts)
