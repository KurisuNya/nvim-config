----------------
--  troubles  --
----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>x", "<Cmd>TroubleToggle<CR>", opts)
