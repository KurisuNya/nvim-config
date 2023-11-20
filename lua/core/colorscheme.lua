------------------
-- colorscheme  --
------------------
local M = {}
M.colorscheme_plugin = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "storm",
			dim_inactive = false,
			lualine_bold = true,
			hide_inactive_statusline = false,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
			},
		})
		vim.cmd.colorscheme("tokyonight-storm")
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#29a4bd", bg = "NONE" })
		vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bold = true, bg = "#2e3c64" })
	end,
}
M.lualine = "tokyonight"
return M
