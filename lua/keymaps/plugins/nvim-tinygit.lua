local M = {}
M.keys = function()
	vim.keymap.set("n", "<leader>gc", require("tinygit").smartCommit, {
		noremap = true,
		silent = true,
		desc = "Git Commit (Auto Add)",
	})
	vim.keymap.set("n", "<leader>gp", require("tinygit").push, {
		noremap = true,
		silent = true,
		desc = "Git Push",
	})
	vim.keymap.set("n", "<leader>gh", require("tinygit").fileHistory, {
		noremap = true,
		silent = true,
		desc = "Git History File",
	})
end
return M
