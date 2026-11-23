---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("KurisuNya/hlsearch.nvim"),
  event = PicoPack.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<C-h>",
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

PicoPack.register(spec)
