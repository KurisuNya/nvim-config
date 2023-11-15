--------------------
--                --
--      nvim      --
--                --
--------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
---------------------
--   better-move   --
---------------------
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "J", "5gj", opts)
keymap.set({ "n", "x" }, "K", "5gk", opts)
keymap.set({ "n", "x" }, "<S-Down>", "5gj", opts)
keymap.set({ "n", "x" }, "<S-Up>", "5gk", opts)
keymap.set({ "n", "x" }, "#", "*", opts)
keymap.set({ "n", "x" }, "*", "#", opts)
--------------------
--   normal-mod   --
--------------------
--编辑器保存退出
keymap.set("n", "<C-s>", "<Cmd>w<CR>", opts)
keymap.set("n", "<leader>w", "<Cmd>w<CR>", opts)
keymap.set("n", "<leader>q", "<Cmd>q<CR>", opts)
keymap.set("n", "<leader>W", "<Cmd>wq<CR>", opts)
keymap.set("n", "<leader>Q", "<Cmd>q!<CR>", opts)
--窗口操作
keymap.set("n", "s", "", opts)
keymap.set("n", "<leader><Right>", "<Cmd>vsp<CR>", opts)
keymap.set("n", "<leader><Down>", "<Cmd>sp<CR>", opts)
keymap.set("n", "<leader><Left>", "<C-w>c", opts)
keymap.set("n", "<leader><Up>", "<C-w>o", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-Left>", "<C-w>h", opts)
keymap.set("n", "<C-Down>", "<C-w>j", opts)
keymap.set("n", "<C-Up>", "<C-w>k", opts)
keymap.set("n", "<C-Right>", "<C-w>l", opts)
--打开终端
keymap.set("n", "<leader>vt", "<Cmd>vsp term://fish<CR>", opts)
--行操作
keymap.set("n", "<leader><Enter>", 'O<Esc>"_cc<Esc>j', opts)
keymap.set("n", "<leader>j", "J", opts)
keymap.set("n", "<leader>k", "i<CR><Up><Esc>A", opts)
--取消高亮
keymap.set("n", "<leader>/", "<Cmd>noh<CR>", opts)
--数字加减
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "_", "<C-x>", opts)
--------------------
--   visual-mod   --
--------------------
--黏贴替换文本
keymap.set("x", "p", '"_dP', opts)
--数字加减
keymap.set("x", "+", "<C-a>", opts)
keymap.set("x", "_", "<C-x>", opts)
keymap.set("x", "g+", "g<C-a>", opts)
keymap.set("x", "g_", "g<C-x>", opts)
--缩进优化
keymap.set("x", "<", "<gv")
keymap.set("x", ">", ">gv")
----------------------
--   terminal-mod   --
----------------------
--终端窗口操作
keymap.set("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opts)
keymap.set("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opts)
keymap.set("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opts)
keymap.set("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opts)
keymap.set("t", "<C-Left>", [[ <C-\><C-N><C-w>h ]], opts)
keymap.set("t", "<C-Down>", [[ <C-\><C-N><C-w>j ]], opts)
keymap.set("t", "<C-Up>", [[ <C-\><C-N><C-w>k ]], opts)
keymap.set("t", "<C-Right>", [[ <C-\><C-N><C-w>l ]], opts)
