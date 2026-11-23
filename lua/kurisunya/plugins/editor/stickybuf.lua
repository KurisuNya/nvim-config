PicoPack.register({
  PicoPack.url.gh("stevearc/stickybuf.nvim"),
  opts = {},
  config = function(opts) require("stickybuf").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
