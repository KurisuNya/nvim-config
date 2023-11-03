----------------
--  troubles  --
----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>x", "<cmd>TroubleToggle<cr>", opts)
