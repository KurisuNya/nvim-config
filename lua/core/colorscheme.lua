------------------
-- colorscheme  --
------------------
local M = {}
M.colorscheme_plugin = {
	"folke/tokyonight.nvim",
	config = function()
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
	end,
	lazy = false,
}
M.lualine = "tokyonight"
return M
