return {
  "KurisuNya/hlsearch.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
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
      silent = true,
      desc = "Toggle hlsearch",
    },
  },
}
