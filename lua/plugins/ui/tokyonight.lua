---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	require("tokyonight").setup({
		style = "storm",
		lualine_bold = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
		},
		on_highlights = function(hl, c)
			hl.TelescopePromptNormal = hl.TelescopeNormal
			hl.TelescopePromptBorder = hl.TelescopeBorder
			hl.TelescopePromptTitle = hl.TelescopeTitle
			hl.LspSignatureActiveParameter = hl.Visual
			hl.CursorLineNr = { fg = c.dark5 }
		end,
	})
	vim.cmd.colorscheme("tokyonight-storm")
	-- barbar highlights
	vim.api.nvim_set_hl(0, "BufferCurrentSign", {
		bg = KurisuNya.utils.get_hl_color("BufferCurrentSign", "bg#"),
		fg = KurisuNya.utils.get_hl_color("Title", "fg#"),
	})
	vim.api.nvim_set_hl(0, "BufferVisibleSign", {
		bg = KurisuNya.utils.get_hl_color("BufferVisibleSign", "bg#"),
		fg = KurisuNya.utils.get_hl_color("BufferInactive", "fg#"),
	})
	vim.api.nvim_set_hl(0, "BufferInactiveSign", {
		bg = KurisuNya.utils.get_hl_color("BufferInactiveSign", "bg#"),
		fg = KurisuNya.utils.get_hl_color("BufferInactive", "fg#"),
	})
	-- virt-column
	vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#3b4261", bg = "NONE" })
	-- indent-blankline
	vim.api.nvim_set_hl(0, "IBLSelected", {
		fg = KurisuNya.utils.get_hl_color("IncSearch", "bg#"),
	})
	-- nvim-dap-ui
	vim.api.nvim_set_hl(0, "DapBreakpoint", {
		ctermbg = 0,
		fg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextError", "fg#"),
		bg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextError", "bg#"),
	})
	vim.api.nvim_set_hl(0, "DapLogPoint", {
		ctermbg = 0,
		fg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextInfo", "fg#"),
		bg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextInfo", "bg#"),
	})
	vim.api.nvim_set_hl(0, "DapStopped", {
		ctermbg = 0,
		fg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextHint", "fg#"),
		bg = KurisuNya.utils.get_hl_color("DiagnosticVirtualTextHint", "bg#"),
	})
end
return M
