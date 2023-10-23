-----------------------
--  CamelCaseMotion  --
-----------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<A-w>", "<Plug>CamelCaseMotion_w", opts)
keymap.set("n", "<A-b>", "<Plug>CamelCaseMotion_b", opts)
keymap.set("n", "<A-e>", "<Plug>CamelCaseMotion_e", opts)
