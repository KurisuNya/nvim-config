------ enable fast loader ------
vim.loader.enable()
------ leader-key ------
vim.g.mapleader = " "
------ user-plugins ------
require("plugins")
------ user-theme ------
require("core.colorscheme")
------ user-options ------
require("core.options")
------ user-keymap ------
require("core.keymaps")
