---@type Manager.Spec
local spec = {
  Manager.url.gh("folke/snacks.nvim"),
  lazy = false,
  priority = 9000,
}

spec.opts = function()
  local opts = {
    dashboard = {
      enabled = true,
      preset = { header = Config.dashboard.header },
    },
    quickfile = { enabled = true },
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      icons = Icons.log_levels,
      width = { min = 30, max = 0.4 },
    },
    styles = {
      notification = {
        border = Config.border_style,
        wo = { wrap = true },
      },
    },
  }

  local dashboard_keys = {}
  for _, cfg in ipairs(Config.dashboard.buttons) do
    table.insert(dashboard_keys, {
      text = {
        { cfg.name, hl = "special", width = 45 },
        { cfg.key, hl = "comment" },
      },
      action = cfg.cmd,
      key = cfg.key,
      align = "center",
    })
  end
  opts.dashboard.preset.keys = dashboard_keys

  opts.dashboard.sections = {
    { section = "header", padding = 4 },
    { section = "keys", gap = 1, padding = 2 },
    function()
      local stats = Manager.stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
        align = "center",
        text = {
          { Config.dashboard.footer_name .. " | ", hl = "comment" },
          { stats.loaded .. "/" .. stats.total .. " plugins ", hl = "comment" },
          { "in " .. ms .. "ms", hl = "comment" },
        },
      }
    end,
  }
  return opts
end

spec.init = function()
  local notifs = {}
  local function temp(...) table.insert(notifs, vim.F.pack_len(...)) end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.uv.new_timer()
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

spec.config = function(opts)
  local notify = vim.notify
  require("snacks").setup(opts)
  vim.o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
  -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
  -- this is needed to have early notifications show up in noice history
  if Manager.have("noice.nvim") then
    vim.notify = notify
  end
end

Manager.opts_extend("lualine.nvim", {
  custom = { disabled_filetypes = { "snacks_dashboard" } },
}, { extend = "custom.disabled_filetypes" })

Manager.add(spec)
