local M = {
	"ziontee113/icon-picker.nvim",
	opts = { disable_legacy_commands = true },
	event = "VeryLazy",
}
M.keys = {
	{
		"<leader>ic",
		"<CMD>IconPickerYank<CR>",
		desc = "IconPicker Open",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
