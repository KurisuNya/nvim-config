------------------
--  nvim-picgo  --
------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = false }
keymap.set("n", "<leader>pp", ":PicgoUpload ~/Pictures/", opts)
