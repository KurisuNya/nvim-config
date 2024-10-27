vim.loader.enable()
vim.g.mapleader = " "
_G.KurisuNya = {}
_G.PluginVar = {}
require("global_cfg")
require("utils")
if KurisuNya.config.enable_plugin then
	require("plugins")
end
require("core.options")
require("core.autocmd")
require("keymaps.core")
