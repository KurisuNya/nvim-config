-------------------
--  easy-action  --
-------------------
local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "x" }, "<leader><leader>a", "<Cmd>BasicEasyAction<CR>", opts)
