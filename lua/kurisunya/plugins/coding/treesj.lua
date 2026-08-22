---@type Manager.Spec
local spec = {
  Manager.url.gh("Wansmer/treesj"),
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<leader>k",
    function() require("treesj").toggle() end,
    { desc = "Join/Split Node" },
  },
}

spec.opts = {
  use_default_keymaps = false,
  max_join_length = 1000,
  notify = false,
}

spec.config = function(opts)
  require("treesj").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.add(spec)
