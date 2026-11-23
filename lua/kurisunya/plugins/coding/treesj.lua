---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("Wansmer/treesj"),
  event = PicoPack.event.VeryLazy,
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

PicoPack.register(spec)
