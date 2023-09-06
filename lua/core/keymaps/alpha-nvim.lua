------------------
--  alpha-nvim  --
------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader><leader>d", ":Alpha<cr>", opts)
