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
keymap.set("n", "<C-s>", ":w<cr>", opts)
keymap.set("n", "<leader>w", ":w<cr>", opts)
keymap.set("n", "<leader>q", ":q<cr>", opts)
keymap.set("n", "<leader>W", ":wq<cr>", opts)
keymap.set("n", "<leader>Q", ":q!<cr>", opts)
--窗口操作
keymap.set("n", "s", "", opts)
keymap.set("n", "<leader><Right>", ":vsp<CR>", opts)
keymap.set("n", "<leader><Down>", ":sp<CR>", opts)
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
keymap.set("n", "<leader>t", ":sp term://fish<CR>", opts)
keymap.set("n", "<leader>vt", ":vsp term://fish<CR>", opts)
--行操作
keymap.set("n", "<Enter>", 'O<Esc>"_cc<Esc>j', opts)
keymap.set("n", "<leader><Enter>", 'o<Esc>"_cc<Esc>', opts)
keymap.set("n", "<leader>j", "J", opts)
keymap.set("n", "<leader>k", "i<cr><Up><Esc>A", opts)
--快速移动
keymap.set("n", "J", "5j", opts)
keymap.set("n", "K", "5k", opts)
keymap.set("n", "<S-Down>", "5j", opts)
keymap.set("n", "<S-Up>", "5k", opts)
--取消高亮
keymap.set("n", "<leader>/", ":noh<cr>", opts)
--数字加减
keymap.set("n", "+", "<C-a>", opts)
keymap.set("n", "_", "<C-x>", opts)
--拼写检查
keymap.set("n", "<leader>sc", ":setlocal spell! spelllang=en_us<cr>", opts)
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
