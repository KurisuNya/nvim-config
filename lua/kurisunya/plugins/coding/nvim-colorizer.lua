Manager.add({
  Manager.url.gh("catgoose/nvim-colorizer.lua"),
  opts = {
    options = {
      parsers = {
        names = { enable = false },
        hex = {
          enable = true,
          rgb = false, -- #RGB
          rgba = false, -- #RGBA
          rrggbb = true, -- #RRGGBB
          rrggbbaa = true, -- #RRGGBBAA
          aarrggbb = false, -- 0xAARRGGBB
        },
      },
    },
  },
  config = function(opts) require("colorizer").setup(opts) end,
  event = Manager.event.VeryLazy,
})
