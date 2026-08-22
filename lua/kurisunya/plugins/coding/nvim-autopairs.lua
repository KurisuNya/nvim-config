Manager.add({
  Manager.url.gh("windwp/nvim-autopairs"),
  opts = { check_ts = true },
  config = function(opts) require("nvim-autopairs").setup(opts) end,
  event = Manager.event.VeryLazy,
})
