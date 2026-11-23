PicoPack.register({
  PicoPack.url.gh("stevearc/quicker.nvim"),
  opts = {},
  config = function(opts) require("quicker").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
