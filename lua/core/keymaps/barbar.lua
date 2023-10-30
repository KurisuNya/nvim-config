--------------
--  barbar  --
--------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--切换标签
keymap.set("n", "<A-l>", ":BufferNext<CR>", opts)
keymap.set("n", "<A-h>", ":BufferPrevious<CR>", opts)
keymap.set("n", "<A-j>", ":BufferNext<CR>", opts)
keymap.set("n", "<A-k>", ":BufferPrevious<CR>", opts)
keymap.set("n", "<A-Right>", ":BufferNext<CR>", opts)
keymap.set("n", "<A-Left>", ":BufferPrevious<CR>", opts)
keymap.set("n", "<A-Down>", ":BufferNext<CR>", opts)
keymap.set("n", "<A-Up>", ":BufferPrevious<CR>", opts)
keymap.set("n", "<A-1>", ":BufferGoto 1<CR>", opts)
keymap.set("n", "<A-2>", ":BufferGoto 2<CR>", opts)
keymap.set("n", "<A-3>", ":BufferGoto 3<CR>", opts)
keymap.set("n", "<A-4>", ":BufferGoto 4<CR>", opts)
keymap.set("n", "<A-5>", ":BufferGoto 5<CR>", opts)
keymap.set("n", "<A-6>", ":BufferGoto 6<CR>", opts)
keymap.set("n", "<A-7>", ":BufferGoto 7<CR>", opts)
keymap.set("n", "<A-8>", ":BufferGoto 8<CR>", opts)
keymap.set("n", "<A-9>", ":BufferGoto 9<CR>", opts)
keymap.set("n", "<A-0>", ":BufferLast<CR>", opts)
--关闭标签
keymap.set("n", "<A-q>", ":BufferClose<CR>", opts)
keymap.set("n", "<A-Q>", ":BufferCloseAllButPinned<CR>", opts)
--固定标签
keymap.set("n", "<A-p>", ":BufferPin<CR>", opts)
--移动标签
keymap.set("n", "<A-,>", ":BufferMovePrevious<CR>", opts)
keymap.set("n", "<A-.>", ":BufferMoveNext<CR>", opts)
keymap.set("n", "<A-s>", ":BufferOrderByDirectory<CR>", opts)
