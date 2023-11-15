-------------------
--  icon-picker  --
-------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>ic", "<Cmd>IconPickerYank<CR>", opts)
