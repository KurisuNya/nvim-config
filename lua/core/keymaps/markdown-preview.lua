------------------------
--  markdown-preview  --
------------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", opts)
