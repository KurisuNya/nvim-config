Manager.add({
  Manager.url.gh("folke/ts-comments.nvim"),
  opts = {},
  config = function(opts) require("ts-comments").setup(opts) end,
  event = Manager.event.VeryLazy,
})
