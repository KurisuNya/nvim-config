vim.loader.enable()

require("kurisunya.utils")
require("kurisunya.config")
require("kurisunya.icons")

require("kurisunya.native.options")
require("kurisunya.native.keymaps")
require("kurisunya.native.autocmd")

local lazy_notify = function()
  local notifs = {}
  local function temp(...) table.insert(notifs, vim.F.pack_len(...)) end

  local orig = vim.notify
  vim.notify = temp

  local timer = assert(vim.uv.new_timer())
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

if Config.use_plugins then
  lazy_notify()
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
