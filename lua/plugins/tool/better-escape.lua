local better_escape_status, better_escape = pcall(require, "better_escape")
if not better_escape_status then
	return
end
local map_list = require("core.keymaps").better_escape
better_escape.setup({
	mapping = map_list.mapping,
	timeout = 400,
	clear_empty_lines = false,
	keys = map_list.keys,
})
