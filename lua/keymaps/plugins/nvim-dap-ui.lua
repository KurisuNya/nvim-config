local M = {}
M.keys = function()
	local nvim_dap_ui = require("dapui")
	vim.keymap.set("n", "<leader>du", function()
		nvim_dap_ui.toggle({ reset = true })
		PluginVar.debugui = not PluginVar.debugui
	end, { noremap = true, silent = true, desc = "Dap UI Toggle" })

	vim.keymap.set("n", "<leader>de", function()
		nvim_dap_ui.eval()
	end, { noremap = true, silent = true, desc = "Dap UI Eval" })
end
M.normal_mappings = {
	edit = "e",
	expand = { "<CR>", "<2-LeftMouse>" },
	open = "o",
	remove = "d",
	repl = "r",
	toggle = "t",
}
M.float_mappings = { close = { "q", "<Esc>" } }
return M
