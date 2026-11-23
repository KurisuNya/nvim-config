PicoPack.register({
  PicoPack.url.gh("Darazaki/indent-o-matic"),
  opts = { skip_multiline = true },
  config = function(opts) require("indent-o-matic").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
