Manager.add({
  Manager.url.gh("kylechui/nvim-surround"),
  opts = {},
  config = function(opts) require("nvim-surround").setup(opts) end,
  event = Manager.event.VeryLazy,
})
