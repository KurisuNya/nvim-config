---@type Manager.Spec
local spec = {
  Manager.url.gh("nguyenvukhang/nvim-toggler"),
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<leader>a",
    function() require("nvim-toggler").toggle() end,
    { desc = "Word Meaning Toggle" },
  },
}

spec.opts = {
  remove_default_keybinds = true,
  inverses = {
    ["true"] = "false",
    ["True"] = "False",
    ["TRUE"] = "FALSE",
    ["yes"] = "no",
    ["Yes"] = "No",
    ["YES"] = "NO",
    ["on"] = "off",
    ["On"] = "Off",
    ["ON"] = "OFF",
    ["enable"] = "disable",
    ["Enable"] = "Disable",
    ["ENABLE"] = "DISABLE",
  },
}

spec.config = function(opts)
  require("nvim-toggler").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.add(spec)
