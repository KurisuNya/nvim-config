--------------------
--                --
--      nvim      --
--                --
--------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set({ "n", "x" }, "q", "", opts)
keymap.set({ "n", "x" }, "Q", "", opts)
keymap.set({ "n", "x" }, "ZZ", "", opts)
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
--------------------
--   normal-mod   --
--------------------
--编辑器保存退出
keymap.set("n", "<C-s>", "<Cmd>w<CR>", opts)
keymap.set("n", "<leader>w", "<Cmd>w<CR>", {
	noremap = true,
	silent = true,
	desc = "Save",
})
keymap.set("n", "<leader>q", "<Cmd>q<CR>", {
	noremap = true,
	silent = true,
	desc = "Quit",
})
keymap.set("n", "<leader>W", "<Cmd>wq<CR>", {
	noremap = true,
	silent = true,
	desc = "Save Quit",
})
keymap.set("n", "<leader>Q", "<Cmd>q!<CR>", {
	noremap = true,
	silent = true,
	desc = "Force Quit",
})
-- 宏录制
keymap.set("n", "<leader>M", "q", {
	noremap = true,
	silent = true,
	desc = "Record Marco",
})
--窗口操作
keymap.set("n", "<leader><Right>", "<Cmd>vsp<CR>", {
	noremap = true,
	silent = true,
	desc = "Vertical Spilt Window",
})
keymap.set("n", "<leader><Down>", "<Cmd>sp<CR>", {
	noremap = true,
	silent = true,
	desc = "Horizontal Spilt Window",
})
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-Left>", "<C-w>h", opts)
keymap.set("n", "<C-Down>", "<C-w>j", opts)
keymap.set("n", "<C-Up>", "<C-w>k", opts)
keymap.set("n", "<C-Right>", "<C-w>l", opts)
--行操作
keymap.set("n", "<leader><Enter>", 'O<Esc>"_cc<Esc>j', {
	noremap = true,
	silent = true,
	desc = "Empty Line",
})
keymap.set("n", "<leader>j", "J", {
	noremap = true,
	silent = true,
	desc = "Joint Lines",
})
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
