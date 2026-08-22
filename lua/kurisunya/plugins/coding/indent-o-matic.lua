Manager.add({
  Manager.url.gh("Darazaki/indent-o-matic"),
  opts = { skip_multiline = true },
  config = function(opts) require("indent-o-matic").setup(opts) end,
  event = Manager.event.VeryLazy,
})
