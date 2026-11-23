PicoPack.register({
  PicoPack.url.gh("RRethy/vim-illuminate"),
  opts = { disable_keymaps = true },
  config = function(opts) require("illuminate").configure(opts) end,
  event = PicoPack.event.VeryLazy,
})
