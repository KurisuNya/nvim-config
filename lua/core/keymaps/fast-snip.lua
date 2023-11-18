local M = {}
M.keys = function()
	local fast_snip = require("fast-snip")
	vim.keymap.set("x", "<leader>cs", function()
		fast_snip.new_snippet_or_add_placeholder()
		vim.cmd("normal !u")
	end, {
		noremap = true,
		silent = true,
		desc = "FastSnip Add",
	})
	vim.keymap.set("n", "<leader>cs", fast_snip.finalize_snippet, {
		noremap = true,
		silent = true,
		desc = "FastSnip Add",
	})
end
return M
