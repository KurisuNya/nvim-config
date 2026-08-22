---@type Manager.Spec
local spec = {
  Manager.url.gh("KurisuNya/hlsearch.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<C-l>",
    function()
      local hlsearch = require("hlsearch")
      local enabled = hlsearch.is_enabled()
      hlsearch.set_enabled(not enabled)
      vim.notify(
        (enabled and "hlsearch disabled" or "hlsearch enabled"),
        vim.log.levels.INFO,
        { title = "hlsearch.nvim" }
      )
    end,
    { desc = "Hlsearch Toggle" },
  },
}

spec.config = function()
  require("hlsearch").setup()
  Utils.keymap.set_maps(maps)
end

Manager.add(spec)
