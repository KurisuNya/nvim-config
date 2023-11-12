------------------
-- colorscheme  --
------------------
local status, tokyonight = pcall(require, "tokyonight")
if not status then
	print("Colorscheme not found!")
	return
end
tokyonight.setup({
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
vim.api.nvim_set_hl(0, "LspSagaFinderSelection", { fg = "#29a4bd", bg = "NONE" })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bold = true, bg = "#2e3c64" })
local M = {}
M.lualine = "tokyonight"
return M
-- vim.cmd.colorscheme("catppuccin-macchiato")
-- local M = {}
-- M.lualine = "catppuccin"
-- return M
