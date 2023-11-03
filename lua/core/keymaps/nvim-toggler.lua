--------------------
--  nvim-spectre  --
--------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>a", require("nvim-toggler").toggle, opts)
