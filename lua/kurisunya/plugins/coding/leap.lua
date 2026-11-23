---@type PicoPack.Spec
local spec = {
  PicoPack.url.cb("andyg/leap.nvim"),
  event = PicoPack.event.VeryLazy,
}

local maps = {
  { "n", "s", "<Plug>(leap-forward)" },
  { "n", "S", "<Plug>(leap-backward)" },
}

spec.config = function() Utils.keymap.set_maps(maps) end

PicoPack.register(spec)
