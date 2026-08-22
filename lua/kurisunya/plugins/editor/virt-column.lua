Manager.add({
  Manager.url.gh("lukas-reineke/virt-column.nvim"),
  opts = { char = "▕", highlight = "VirtColumn" },
  config = function(opts) require("virt-column").setup(opts) end,
  event = Manager.event.VeryLazy,
})
