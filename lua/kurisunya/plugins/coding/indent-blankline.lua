---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("lukas-reineke/indent-blankline.nvim"),
  event = PicoPack.event.VeryLazy,
}

spec.opts = {
  indent = {
    char = "▎",
    tab_char = "▎",
  },
}

spec.config = function(opts) require("ibl").setup(opts) end

PicoPack.register(spec)
