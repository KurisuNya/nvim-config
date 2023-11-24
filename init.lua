vim.loader.enable()
vim.g.mapleader = " "
_G.use_copilot = false
require("plugins")
require("core.options")
require("core.autocommand")
require("core.keymaps.nvim")
