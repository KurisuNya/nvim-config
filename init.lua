vim.loader.enable()

require("kurisunya.utils")
require("kurisunya.config")
require("kurisunya.icons")

require("kurisunya.native.options")
require("kurisunya.native.keymaps")
require("kurisunya.native.autocmd")

if Config.use_plugins then
  require("kurisunya.manager")
  require("kurisunya.plugins")
  if Config.clean_unmanaged_plugins then
    Utils.safecall.later(function()
      local unmanaged = Manager.unmanaged()
      if #unmanaged > 0 then
        vim.pack.del(unmanaged)
      end
    end)
  end
end
