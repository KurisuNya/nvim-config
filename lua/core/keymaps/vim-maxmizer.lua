---------------------
--  vim-maximizer  --
---------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>ms", ":MaximizerToggle<CR>", opts)
