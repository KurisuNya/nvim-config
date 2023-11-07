--------------
--  barbar  --
--------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--切换标签
keymap.set("n", "<A-l>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-h>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-j>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-k>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-Right>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-Left>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-Down>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-Up>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
--关闭标签
keymap.set("n", "<A-q>", "<Cmd>BufferClose<CR>", opts)
keymap.set("n", "<A-Q>", "<Cmd>BufferCloseAllButPinned<CR>", opts)
--固定标签
keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
--移动标签
keymap.set("n", "<A-,>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<A-.>", "<Cmd>BufferMoveNext<CR>", opts)
keymap.set("n", "<A-s>", "<Cmd>BufferOrderByDirectory<CR>", opts)
