vim.loader.enable()
vim.g.mapleader = " "
_G.use_copilot = true
require("plugins")
require("core.options")
require("core.autocommand")
require("core.keymaps.nvim")
