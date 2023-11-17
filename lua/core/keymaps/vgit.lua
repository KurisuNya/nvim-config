------------
--  vgit  --
------------
local status, vgit = pcall(require, "vgit")
if not status then
	return
end
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>z", vgit.buffer_hunk_preview, opts)
keymap.set("n", "<leader>gp", vgit.buffer_diff_preview, opts)
keymap.set("n", "<leader>gh", vgit.buffer_history_preview, opts)
keymap.set("n", "<leader>gd", vgit.project_diff_preview, opts)
