-----------------
--  telescope  --
-----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--查找文件
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", opts)
--模糊查找
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", opts)
--查找项目
keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
--查看git-commit(全局)
keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", opts)
--查看git-branch
keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", opts)
--undo-tree
keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", opts)
