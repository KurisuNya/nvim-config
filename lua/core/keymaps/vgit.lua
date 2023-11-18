local M = {}
M.keys = function()
	local vgit = require("vgit")
	vim.keymap.set("n", "<leader>z", vgit.buffer_hunk_preview, {
		noremap = true,
		silent = true,
		desc = "Buffer Hunk Preview",
	})
	vim.keymap.set("n", "<leader>gp", vgit.buffer_diff_preview, {
		noremap = true,
		silent = true,
		desc = "Buffer Diff Preview",
	})
	vim.keymap.set("n", "<leader>gh", vgit.buffer_history_preview, {
		noremap = true,
		silent = true,
		desc = "Buffer History Preview",
	})
	vim.keymap.set("n", "<leader>gd", vgit.project_diff_preview, {
		noremap = true,
		silent = true,
		desc = "Project Diff Preview",
	})
end
return M
