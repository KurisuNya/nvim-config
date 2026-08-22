Manager.add({
  Manager.url.gh("nacro90/numb.nvim"),
  opts = {},
  config = function(opts) require("numb").setup(opts) end,
  event = Manager.event.VeryLazy,
})
