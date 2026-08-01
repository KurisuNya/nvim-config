_G.Config = require("config")
_G.Icons = require("utils.icons")
_G.Utils = require("utils.utils")

require("native.options")
require("native.keymaps")
require("native.autocmd")

if Config.enable_plugins then
	require("plugins")
end
