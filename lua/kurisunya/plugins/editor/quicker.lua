Manager.add({
  Manager.url.gh("stevearc/quicker.nvim"),
  opts = {},
  config = function(opts) require("quicker").setup(opts) end,
  event = Manager.event.VeryLazy,
})
