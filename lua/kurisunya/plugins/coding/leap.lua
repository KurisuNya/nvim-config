---@type Manager.Spec
local spec = {
  Manager.url.cb("andyg/leap.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  { "n", "s", "<Plug>(leap-forward)" },
  { "n", "S", "<Plug>(leap-backward)" },
}

spec.config = function() Utils.keymap.set_maps(maps) end

Manager.add(spec)
