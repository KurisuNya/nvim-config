local M = {}
M.keys = function()
	local nvim_dap_ui = require("dapui")
	_G._debugui = false
	vim.keymap.set("n", "<leader>de", function()
		if package.loaded["dap"] and require("dap").status() ~= "" then
			nvim_dap_ui.eval()
		end
	end, {
		noremap = true,
		silent = true,
		desc = "Dap Eval",
	})
	vim.keymap.set("n", "<leader>du", function()
		nvim_dap_ui.toggle({ reset = true })
		_G._debugui = not _G._debugui
	end, {
		noremap = true,
		silent = true,
		desc = "Dap UI Toggle",
	})
end
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
