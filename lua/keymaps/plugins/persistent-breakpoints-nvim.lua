local M = {}
M.keys = function()
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
