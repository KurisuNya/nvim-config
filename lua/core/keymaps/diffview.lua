----------------
--  diffview  --
----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--打开差异视图
keymap.set("n", "<leader>vd", "<Cmd>DiffviewOpen<CR>", opts)
--关闭差异视图
keymap.set("n", "<leader>cd", "<Cmd>DiffviewClose<CR>", opts)
--打开文件历史视图
keymap.set("n", "<leader>hd", "<Cmd>DiffviewFileHistory<CR>", opts)
