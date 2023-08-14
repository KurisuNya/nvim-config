------------------
--  bufferline  --
------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--切换标签
keymap.set("n", "<A-l>", ":BufferLineCycleNext<CR>", opts)
keymap.set("n", "<A-h>", ":BufferLineCyclePrev<CR>", opts)
keymap.set("n", "<A-j>", ":BufferLineCycleNext<CR>", opts)
keymap.set("n", "<A-k>", ":BufferLineCyclePrev<CR>", opts)
keymap.set("n", "<A-Right>", ":BufferLineCycleNext<CR>", opts)
keymap.set("n", "<A-Left>", ":BufferLineCyclePrev<CR>", opts)
keymap.set("n", "<A-Down>", ":BufferLineCycleNext<CR>", opts)
keymap.set("n", "<A-Up>", ":BufferLineCyclePrev<CR>", opts)
--关闭标签
keymap.set("n", "<A-q>", ":BufDel!<CR>", opts)
keymap.set("n", "<A-Q>", ":BufDel!<CR>", opts)
keymap.set("n", "<leader><A-q>", ":BufferLinePickClose<CR>", opts)
