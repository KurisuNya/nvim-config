------------------
-- colorscheme  --
------------------
local status, tokyonight = pcall(require, "tokyonight")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
tokyonight.setup({
	style = "storm",
	dim_inactive = true,
	lualine_bold = true,
	styles = {
		comments = { italic = false },
		keywords = { italic = true },
	},
})
-- vim.cmd.colorscheme("everforest")
vim.cmd.colorscheme("tokyonight-storm")
local M = {}
-- M.lualine = "everforest"
M.lualine = "tokyonight"
return M
