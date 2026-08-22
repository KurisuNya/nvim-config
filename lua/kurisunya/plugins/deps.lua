Manager.add({
  Manager.url.gh("nvim-mini/mini.icons"),
  config = function()
    local style = Config.use_nerd_font and "glyph" or "ascii"
    require("mini.icons").setup({ style = style })
    require("mini.icons").mock_nvim_web_devicons()
  end,
})
