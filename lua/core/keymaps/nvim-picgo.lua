------------------
--  nvim-picgo  --
------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = false }
keymap.set("n", "<leader>pc", ":PicgoUpload ~/Pictures/", opts)
