-------------------
--  nvim-dap-ui  --
-------------------
local status, nvim_dap_ui = pcall(require, "dapui")
if not status then
	return
end
local keymap = vim.keymap
local opts = { noremap = true, silent = false }
keymap.set("n", "L", nvim_dap_ui.eval, opts)
keymap.set("n", "<leader>du", function()
	nvim_dap_ui.toggle({ reset = true })
end, opts)
local M = {}
M.normal_mappings = {
	edit = "e",
	expand = { "<CR>", "<2-LeftMouse>" },
	open = "o",
	remove = "d",
	repl = "r",
	toggle = "t",
}
M.float_mappings = {
	close = { "q", "<Esc>" },
}
return M
