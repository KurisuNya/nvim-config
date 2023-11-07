------------------
--  gitsigins  --
------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
--打开文件内部git-status
keymap.set(
	"n",
	"<leader>z",
	"<Cmd>Gitsigns toggle_linehl<CR><Cmd>Gitsigns toggle_numhl<CR><Cmd>Gitsigns toggle_deleted<CR><Cmd>Gitsigns toggle_word_diff<CR>",
	opts
)
