Manager.add({
  Manager.url.gh("KurisuNya/colorschemes.nvim"),
  opts = {
    create_commands = true,
    default_colorscheme = Config.default_colorscheme,
    specs = {},
  },
  config = function(opts) require("colorschemes").setup(opts) end,
  priority = 10000,
  lazy = false,
})
