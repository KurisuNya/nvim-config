-----------
--  hop  --
-----------
local status, hop = pcall(require, "hop")
if not status then
	return
end
local directions = require("hop.hint").HintDirection
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "x" }, "s", function()
	hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set({ "n", "x" }, "S", function()
	hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set({ "n", "x" }, "<leader><leader>w", hop.hint_words, opts)
vim.keymap.set({ "n", "x" }, "<leader><leader>l", hop.hint_lines, opts)
vim.keymap.set({ "n", "x" }, "<leader><leader>a", "<Cmd>BasicEasyAction<CR>", opts)
