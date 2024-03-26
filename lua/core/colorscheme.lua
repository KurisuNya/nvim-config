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
				-- floats = "normal",
			},
			on_highlights = function(hl, c)
				hl.TelescopePromptNormal = hl.TelescopeNormal
				hl.TelescopePromptBorder = hl.TelescopeBorder
				hl.TelescopePromptTitle = hl.TelescopeTitle
			end,
		})
		vim.cmd.colorscheme("tokyonight-storm")
		vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { link = "Visual" })
	end,
	lazy = false,
}
M.lualine = "tokyonight"
return M
