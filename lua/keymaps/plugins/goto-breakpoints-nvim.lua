local M = {}
M.keys = function()
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
return M
