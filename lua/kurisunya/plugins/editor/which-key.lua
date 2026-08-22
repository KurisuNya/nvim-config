Manager.add({
  Manager.url.gh("folke/which-key.nvim"),
  opts = {
    win = {
      width = { min = 30, max = 60 },
      height = { min = 4, max = 0.75 },
      padding = { 0, 1 },
      col = -1,
      row = -1,
      border = Config.border_style,
      title = true,
      title_pos = "left",
    },
    layout = { width = { min = 30 } },
    delay = 1000,
    icons = { mappings = false },
  },
  config = function(opts) require("which-key").setup(opts) end,
  event = Manager.event.VeryLazy,
})
