--------------------
--                --
--      nvim      --
--                --
--------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--------------------
--   normal-mod   --
--------------------
--编辑器保存退出
keymap.set("n", "<C-s>", "<cmd>w<cr>", opts)
keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)
keymap.set("n", "<leader>q", "<cmd>q<cr>", opts)
keymap.set("n", "<leader>W", "<cmd>wq<cr>", opts)
keymap.set("n", "<leader>Q", "<cmd>q!<cr>", opts)
--窗口操作
keymap.set("n", "s", "", opts)
keymap.set("n", "<leader><Right>", "<cmd>vsp<CR>", opts)
keymap.set("n", "<leader><Down>", "<cmd>sp<CR>", opts)
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
keymap.set("n", "<leader>vt", "<cmd>vsp term://fish<CR>", opts)
--行操作
keymap.set("n", "<leader><Enter>", 'O<Esc>"_cc<Esc>j', opts)
keymap.set("n", "<leader>j", "J", opts)
keymap.set("n", "<leader>k", "i<cr><Up><Esc>A", opts)
--快速移动
keymap.set("n", "J", "5j", opts)
keymap.set("n", "K", "5k", opts)
keymap.set("n", "<S-Down>", "5j", opts)
keymap.set("n", "<S-Up>", "5k", opts)
--取消高亮
keymap.set("n", "<leader>/", "<cmd>noh<cr>", opts)
--数字加减
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "_", "<C-x>", opts)
--------------------
--   visual-mod   --
--------------------
--快速移动
keymap.set("v", "J", "5j", opts)
keymap.set("v", "K", "5k", opts)
keymap.set("v", "<S-Down>", "5j", opts)
keymap.set("v", "<S-Up>", "5k", opts)
--黏贴替换文本
keymap.set("v", "p", '"_dP', opts)
--数字加减
keymap.set("v", "+", "<C-a>", opts)
keymap.set("v", "_", "<C-x>", opts)
keymap.set("v", "g+", "g<C-a>", opts)
keymap.set("v", "g_", "g<C-x>", opts)
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
