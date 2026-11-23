PicoPack.register({
  PicoPack.url.gh("michaelb/sniprun"),
  build = "sh install.sh",
  opts = {
    display = { "TempFloatingWindow" },
    borders = Config.border_style,
  },
  config = function(opts) require("sniprun").setup(opts) end,
  event = PicoPack.event.VeryLazy,
})
