---@diagnostic disable: missing-fields

local plugin_specific = {
	["barbar.nvim"] = function(hl, _)
		hl.BufferCurrentSign = { fg = hl.Title.fg, bg = hl.BufferCurrent.bg }
		hl.BufferVisibleSign = { fg = hl.BufferInactive.fg, bg = hl.BufferVisible.bg }
		hl.BufferInactiveSign = hl.BufferInactive
	end,
	["indent-blankline.nvim"] = function(hl, _)
		hl.IblScope = { fg = hl.IncSearch.bg }
	end,
	["lualine.nvim"] = function(hl, _)
		hl.LualineLsp = hl.Comment
		hl.LualineDebug = hl.Debug
	end,
	["noice.nvim"] = function(hl, _)
		hl.LspSignatureActiveParameter = hl.Visual
	end,
	["nvim-dap-ui"] = function(hl, _)
		hl.DapBreakpoint = hl.DiagnosticVirtualTextError
		hl.DapLogPoint = hl.DiagnosticVirtualTextInfo
		hl.DapStopped = hl.DiagnosticVirtualTextHint
	end,
	["nvim-gtd"] = function(hl, _)
		hl.GtdBeacon = { bg = "#c43963" }
		hl.SagaBeacon = { bg = "#c43963" }
	end,
	["nvim-treesitter-context"] = function(hl, _)
		hl.TreesitterContextLineNumber = { fg = hl.CursorLineNr.fg, bg = hl.PmenuSel.bg }
	end,
	["telescope.nvim"] = function(hl, _)
		hl.TelescopePromptNormal = hl.TelescopeNormal
		hl.TelescopePromptBorder = hl.TelescopeBorder
		hl.TelescopePromptTitle = hl.TelescopeTitle
	end,
	["virt-column.nvim"] = function(hl, _)
		hl.VirtColumn = { fg = hl.LineNr.fg }
	end,
}

local activate = function(name)
	require("tokyonight").setup({
		lualine_bold = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
		},
		on_highlights = function(hl, c)
			hl.CursorLineNr = { fg = c.dark5 }
			hl.Folded = { fg = c.fg_dark, bg = c.bg_visual, italic = true }
			for plugin, func in pairs(plugin_specific) do
				if Utils.plugin_exists(plugin) then
					func(hl, c)
				end
			end
		end,
	})
	vim.cmd.colorscheme(name)
end

return {
	"folke/tokyonight.nvim",
	init = function()
		PluginVars.insert(PluginVars.colorscheme_specs, {
			colorschemes = {
				"tokyonight-night",
				"tokyonight-storm",
				"tokyonight-day",
				"tokyonight-moon",
			},
			activate = activate,
		})
	end,
}
