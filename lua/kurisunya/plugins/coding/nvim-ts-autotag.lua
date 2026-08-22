Manager.add({
  Manager.url.gh("windwp/nvim-ts-autotag"),
  opts = {},
  config = function(opts) require("nvim-ts-autotag").setup(opts) end,
  event = Manager.event.VeryLazy,
})
