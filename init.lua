vim.loader.enable()

require("kurisunya.utils")
require("kurisunya.config")
require("kurisunya.icons")

require("kurisunya.native.options")
require("kurisunya.native.keymaps")
require("kurisunya.native.autocmd")

if Config.use_plugins then
  require("kurisunya.manager")
  require("kurisunya.manager.ui") -- TODO: refactor ai generated ui code
  require("kurisunya.plugins")
end
