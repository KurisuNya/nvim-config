--------------
--  barbar  --
--------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--切换标签
keymap.set("n", "<A-l>", "<cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-h>", "<cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-j>", "<cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-k>", "<cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-Right>", "<cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-Left>", "<cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-Down>", "<cmd>BufferNext<CR>", opts)
keymap.set("n", "<A-Up>", "<cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<A-1>", "<cmd>BufferGoto 1<CR>", opts)
keymap.set("n", "<A-2>", "<cmd>BufferGoto 2<CR>", opts)
keymap.set("n", "<A-3>", "<cmd>BufferGoto 3<CR>", opts)
keymap.set("n", "<A-4>", "<cmd>BufferGoto 4<CR>", opts)
keymap.set("n", "<A-5>", "<cmd>BufferGoto 5<CR>", opts)
keymap.set("n", "<A-6>", "<cmd>BufferGoto 6<CR>", opts)
keymap.set("n", "<A-7>", "<cmd>BufferGoto 7<CR>", opts)
keymap.set("n", "<A-8>", "<cmd>BufferGoto 8<CR>", opts)
keymap.set("n", "<A-9>", "<cmd>BufferGoto 9<CR>", opts)
keymap.set("n", "<A-0>", "<cmd>BufferLast<CR>", opts)
--关闭标签
keymap.set("n", "<A-q>", "<cmd>BufferClose<CR>", opts)
keymap.set("n", "<A-Q>", "<cmd>BufferCloseAllButPinned<CR>", opts)
--固定标签
keymap.set("n", "<A-p>", "<cmd>BufferPin<CR>", opts)
--移动标签
keymap.set("n", "<A-,>", "<cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<A-.>", "<cmd>BufferMoveNext<CR>", opts)
keymap.set("n", "<A-s>", "<cmd>BufferOrderByDirectory<CR>", opts)
