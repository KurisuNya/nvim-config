-------------------
--  nvim-dap-ui  --
-------------------
local nvim_dap_ui_status, nvim_dap_ui = pcall(require, "dapui")
if not nvim_dap_ui_status then
	return
end
local vgit_status, vgit = pcall(require, "vgit")
if not vgit_status then
	return
end
local keymap = vim.keymap
local opts = { noremap = true, silent = false }

_G._debugui = false
keymap.set("n", "L", nvim_dap_ui.eval, opts)
keymap.set("n", "L", function()
	if package.loaded["dap"] and require("dap").status() ~= "" then
		nvim_dap_ui.eval()
	else
		vgit.buffer_hunk_preview()
	end
end, opts)
keymap.set("n", "<leader>du", function()
	nvim_dap_ui.toggle({ reset = true })
	_G._debugui = not _G._debugui
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
