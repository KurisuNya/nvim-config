PicoPack.register({
  PicoPack.url.gh("nacro90/numb.nvim"),
  opts = {},
  config = function(opts) require("numb").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
