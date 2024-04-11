vim.loader.enable()
vim.g.mapleader = " "
_G.use_copilot = true
_G.project_dir = { -- define project roots
	"~/Documents/Projects/*/*",
	"~/.config/*",
	"~/.local/share/nvim/lazy/*",
}
require("plugins")
require("core.options")
require("core.autocommand")
require("core.keymaps.nvim")
