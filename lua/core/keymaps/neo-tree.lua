----------------
--  neo-tree  --
----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--开关neo-tree

keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", opts)
