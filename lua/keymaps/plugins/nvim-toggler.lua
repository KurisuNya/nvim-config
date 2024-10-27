local M = {}
M.keys = function()
	vim.keymap.set("n", "<leader>a", require("nvim-toggler").toggle, {
		noremap = true,
		silent = true,
		desc = "Word Meaning Toggle",
	})
end
return M
