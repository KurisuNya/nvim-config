local status, barbar = pcall(require, "barbar")
if not status then
	return
end
local icons = require("plugins.ui.icons")

vim.g.barbar_auto_setup = false
barbar.setup({
	animation = false,
	insert_at_end = true,
	auto_hide = 0,
	modified = { button = icons.git.Modified },
	icons = {
		button = "",
		separator = { left = " ", right = "" },
		separator_at_end = false,
		pinned = { button = "", filename = true },
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = {
				enabled = true,
				icon = icons.diagnostics.Error,
			},
			[vim.diagnostic.severity.WARN] = {
				enabled = true,
				icon = icons.diagnostics.Warning,
			},
			[vim.diagnostic.severity.INFO] = {
				enabled = true,
				icon = icons.diagnostics.Info,
			},
			[vim.diagnostic.severity.HINT] = {
				enabled = true,
				icon = icons.diagnostics.Hint,
			},
		},
	},
	sidebar_filetypes = {
		["neo-tree"] = { event = "BufWipeout", text = "FILE EXPLORER" },
	},
	maximum_padding = 2,
	minimum_padding = 2,
})
