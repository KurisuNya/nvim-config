local status, barbar = pcall(require, "barbar")
if not status then
	return
end
local lsp_ui = require("plugins.ui.lsp-ui")

vim.g.barbar_auto_setup = false
barbar.setup({
	animation = false,
	insert_at_end = true,
	auto_hide = 0,
	icons = {
		button = "",
		separator = { left = " ", right = "" },
		separator_at_end = false,
		pinned = { button = "", filename = true },
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = {
				enabled = true,
				icon = lsp_ui.diagnostics.icons.error,
			},
			[vim.diagnostic.severity.WARN] = {
				enabled = false,
				icon = lsp_ui.diagnostics.icons.warning,
			},
			[vim.diagnostic.severity.INFO] = {
				enabled = false,
				icon = lsp_ui.diagnostics.icons.info,
			},
			[vim.diagnostic.severity.HINT] = {
				enabled = true,
				icon = lsp_ui.diagnostics.icons.hint,
			},
		},
	},
	sidebar_filetypes = {
		["neo-tree"] = { event = "BufWipeout", text = "FILE EXPLORER" },
	},
	maximum_padding = 2,
	minimum_padding = 2,
})
