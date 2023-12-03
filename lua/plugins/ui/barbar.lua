local M = {}
M.config = function()
	local icons = require("plugins.ui.icons")
	local function get_color(group, attr)
		return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
	end
	vim.api.nvim_set_hl(0, "BufferCurrentSign", {
		bg = get_color("BufferCurrentSign", "bg#"),
		fg = "#7aa2f7",
	})
	vim.api.nvim_set_hl(0, "BufferVisibleSign", {
		bg = get_color("BufferVisibleSign", "bg#"),
		fg = get_color("BufferInactive", "fg#"),
	})

	require("barbar").setup({
		animation = false,
		tabpages = false,
		highlight_visible = true,
		modified = { button = icons.git.Modified },
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
		},
		sidebar_filetypes = {
			["neo-tree"] = { event = "BufWipeout", text = "FILE EXPLORER" },
		},
		maximum_padding = 2,
		minimum_padding = 2,
	})
end
return M
