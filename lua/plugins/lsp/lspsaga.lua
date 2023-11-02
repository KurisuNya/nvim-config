local status, lspsaga = pcall(require, "lspsaga")
if not status then
	return
end
lspsaga.setup({
	rename = {
		in_select = false,
		auto_save = true,
	},
	ui = {
		lines = { "└", "├", "│", "─", "┌" },
	},
})
