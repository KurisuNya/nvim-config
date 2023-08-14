-----------------
--  telescope  --
-----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--查找文件
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
--查找语句(全局)
keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", opts)
--模糊查找(当前文件)
keymap.set("n", "<leader>fc", ":Telescope grep_string<cr>", opts)
--查找标签
keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", opts)
--查找帮助
keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>", opts)
--查找定义(全部标签内)
keymap.set("n", "<leader>fd", ":Telescope lsp_document_symbols<cr>", opts)
--查找项目
keymap.set("n", "<leader>fp", ":Telescope projects<cr>", opts)
--查看git-commit(全局)
keymap.set("n", "<leader>gc", ":Telescope git_commits<cr>", opts)
--查看git-commit(当前文件)
keymap.set("n", "<leader>gfc", ":Telescope git_bcommits<cr>", opts)
--查看git-branch
keymap.set("n", "<leader>gb", ":Telescope git_branches<cr>", opts)
--查看git-status
keymap.set("n", "<leader>gs", ":Telescope git_status<cr>", opts)
--undo-tree
keymap.set("n", "<leader>u", ":Telescope undo<cr>", opts)
