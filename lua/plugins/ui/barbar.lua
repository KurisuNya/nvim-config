local M = {}
M.config = function()
	local icons = require("plugins.ui.icons")

	local opts = {
		animation = false,
		tabpages = false,
		highlight_visible = true,
		modified = { button = icons.git.Modified },
		focus_on_close = "left",
		icons = {
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
			separator_at_end = false,
			separator = { left = "▎", right = "" },
			visible = { separator = { left = "▎", right = "" } },
			inactive = { separator = { left = " ", right = "" } },
			pinned = { button = icons.ui.pinned, filename = true },
		},
		maximum_padding = 1,
		minimum_padding = 1,
		no_name_title = "Empty",
	}

	if KurisuNya.utils.plugin_exist("neo-tree.nvim") then
		opts.sidebar_filetypes = {
			["neo-tree"] = { event = "BufWipeout", text = "FILE EXPLORER" },
		}
	end
	require("barbar").setup(opts)
end
return M
