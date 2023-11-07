-----------------
--  telescope  --
-----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--查找文件
keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", opts)
keymap.set("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>", opts)
--模糊查找
keymap.set("n", "<leader>fs", "<Cmd>Telescope live_grep<CR>", opts)
--查找项目
keymap.set("n", "<leader>fp", "<Cmd>Telescope projects<CR>", opts)
--查看git-commit(全局)
keymap.set("n", "<leader>fc", "<Cmd>Telescope git_commits<CR>", opts)
--查看git-branch
keymap.set("n", "<leader>fb", "<Cmd>Telescope git_branches<CR>", opts)
--undo-tree
keymap.set("n", "<leader>u", "<Cmd>Telescope undo<CR>", opts)
