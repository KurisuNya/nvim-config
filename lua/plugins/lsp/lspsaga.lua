local status, lspsaga = pcall(require, "lspsaga")
if not status then
	return
end
local map_list = require("core.keymaps").lspconfig.outline
lspsaga.setup({
	rename = {
		in_select = false,
		auto_save = true,
	},
	outline = {
		layout = "float",
		keys = map_list,
	},
	ui = {
		lines = { "└", "├", "│", "─", "┌" },
	},
})
