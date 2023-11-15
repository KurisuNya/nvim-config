-------------------
--  persistence  --
-------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>ls", require("persistence").load, opts)
