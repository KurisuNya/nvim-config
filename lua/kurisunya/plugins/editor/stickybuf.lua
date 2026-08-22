Manager.add({
  Manager.url.gh("stevearc/stickybuf.nvim"),
  opts = {},
  config = function(opts) require("stickybuf").setup(opts) end,
  event = Manager.event.VeryLazy,
})
