---@diagnostic disable: missing-fields
local M = {}
M.config = function(name)
	require("tokyonight").setup({
		lualine_bold = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
		},
		on_highlights = function(hl, c)
			hl.CursorLineNr = { fg = c.dark5 }
			-- virt-column
			hl.VirtColumn = { fg = hl.LineNr.fg }
			-- telescope
			hl.TelescopePromptNormal = hl.TelescopeNormal
			hl.TelescopePromptBorder = hl.TelescopeBorder
			hl.TelescopePromptTitle = hl.TelescopeTitle
			-- noice
			hl.LspSignatureActiveParameter = hl.Visual
			-- barbar
			hl.BufferCurrentSign = { fg = hl.Title.fg, bg = hl.BufferCurrent.bg }
			hl.BufferVisibleSign = { fg = hl.BufferInactive.fg, bg = hl.BufferVisible.bg }
			hl.BufferInactiveSign = hl.BufferInactive
			-- indent-blankline
			hl.IblScope = { fg = hl.IncSearch.bg }
			-- nvim-dap-ui
			hl.DapBreakpoint = hl.DiagnosticVirtualTextError
			hl.DapLogPoint = hl.DiagnosticVirtualTextInfo
			hl.DapStopped = hl.DiagnosticVirtualTextHint
			-- lualine
			hl.LualineLsp = hl.Comment
			hl.LualineDebug = hl.Debug
		end,
	})
	vim.cmd.colorscheme(name)
end
return M
