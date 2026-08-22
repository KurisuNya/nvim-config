---@type Manager.Spec
local spec = {
  Manager.url.cb("andyg/leap.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  { { "n", "x", "o" }, "s", "<Plug>(leap-forward)" },
  { { "n", "x", "o" }, "S", "<Plug>(leap-backward)" },
}

spec.config = function() Utils.keymap.set_maps(maps) end

Manager.add(spec)
