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
local M = {}
M.lualine = "tokyonight"
return M
-- vim.cmd.colorscheme("catppuccin-macchiato")
-- local M = {}
-- M.lualine = "catppuccin"
-- return M
