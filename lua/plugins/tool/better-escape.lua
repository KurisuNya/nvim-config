local status, better_escape = pcall(require, "better_escape")
if not status then
	return
end
local map_list = require("core.keymaps").better_escape
better_escape.setup({
	mapping = map_list.mapping,
	timeout = 400,
	clear_empty_lines = false,
	keys = map_list.keys,
})
