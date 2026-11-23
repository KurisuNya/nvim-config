PicoPack.register({
  PicoPack.url.gh("kylechui/nvim-surround"),
  opts = {},
  config = function(opts) require("nvim-surround").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
