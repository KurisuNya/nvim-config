vim.loader.enable()
vim.g.mapleader = " "
_G.use_copilot = true
_G.workspaces = { -- define project roots
	{ "~/Documents/Projects/Develop", {} },
	{ "~/Documents/Projects/Reference", {} },
	{ "~/Documents/Projects/Fork", {} },
	{ "~/Documents/Projects/Test", {} },
	{ "~/Documents/Projects/HomeWork", {} },
	"~/.config",
	"~/.local/share/nvim/lazy",
}
require("plugins")
require("core.options")
require("core.autocommand")
require("core.keymaps.nvim")
