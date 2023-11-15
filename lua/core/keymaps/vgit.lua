------------
--  vgit  --
------------
local status, vgit = pcall(require, "vgit")
if not status then
	return
end
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>gu", vgit.buffer_unstage, opts)
keymap.set("n", "<leader>gr", vgit.buffer_hunk_reset, opts)
keymap.set("n", "<leader>gR", vgit.buffer_reset, opts)
keymap.set("n", "<leader>gp", vgit.buffer_diff_preview, opts)
keymap.set("n", "<leader>gh", vgit.buffer_history_preview, opts)
keymap.set("n", "<leader>gd", vgit.project_diff_preview, opts)
-- vgit.buffer_hunk_preview see keymap/nvim-dap-ui.lua
