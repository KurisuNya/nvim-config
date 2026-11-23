PicoPack.register({
  PicoPack.url.gh("windwp/nvim-ts-autotag"),
  opts = {},
  config = function(opts) require("nvim-ts-autotag").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
