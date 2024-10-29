vim.loader.enable()
vim.g.mapleader = " "
_G.KurisuNya = { enable_plugin = true }
KurisuNya.utils = require("utils")
KurisuNya.config = require("global_cfg")

if KurisuNya.enable_plugin then
	_G.PluginVar = {}
	require("plugins")
end
require("core.options")
require("core.autocmd")
require("keymaps.core")
