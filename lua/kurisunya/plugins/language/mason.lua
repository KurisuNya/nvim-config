Manager.add({
  Manager.url.gh("mason-org/mason.nvim"),
  opts = {
    ensure_installed = { "ty" },
    ui = { border = Config.border_style },
  },
  config = function(opts)
    require("mason").setup(opts)
    local tbl = Utils.misc.list_filter_same(opts.ensure_installed)
    local mr = require("mason-registry")
    mr.refresh(function()
      for _, tool in ipairs(tbl) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          vim.notify("Installing " .. tool, vim.log.levels.INFO, { title = "Mason" })
          p:install()
        end
      end
    end)
  end,
  event = Manager.event.VeryLazy,
})
