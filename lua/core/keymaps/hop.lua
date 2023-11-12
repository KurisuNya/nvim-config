-----------
--  hop  --
-----------
local status, hop = pcall(require, "hop")
if not status then
	return
end
local directions = require("hop.hint").HintDirection
local opts = { noremap = true, silent = true }

vim.keymap.set("", "s", function()
	hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set("", "S", function()
	hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set("", "<leader><leader>w", function()
	hop.hint_words()
end, opts)
vim.keymap.set("", "<leader><leader>l", function()
	hop.hint_lines()
end, opts)
