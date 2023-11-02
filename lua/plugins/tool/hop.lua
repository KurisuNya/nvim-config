local status, hop = pcall(require, "hop")
if not status then
	return
end
hop.setup({})

local directions = require("hop.hint").HintDirection
local map_list = require("core.keymaps").hop
local opts = { noremap = true, silent = true }

vim.keymap.set("", map_list.hint_char2_after, function()
	hop.hint_char2({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set("", map_list.hint_char2_before, function()
	hop.hint_char2({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, opts)
vim.keymap.set("", map_list.hint_words, function()
	hop.hint_words()
end, opts)
vim.keymap.set("", map_list.hint_lines, function()
	hop.hint_lines()
end, opts)
