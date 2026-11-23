---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("chrisgrieser/nvim-tinygit"),
  event = PicoPack.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<leader>gc",
    function() require("tinygit").smartCommit() end,
    { desc = "Git Commit" },
  },
  {
    "n",
    "<leader>gp",
    function() require("tinygit").push() end,
    { desc = "Git Push" },
  },
  {
    "n",
    "<leader>gh",
    function() require("tinygit").fileHistory() end,
    { desc = "Git History File" },
  },
}

local border_style = Config.border_style
local fallback = Config.border_style_fallback
border_style = border_style == "none" and fallback or border_style

spec.opts = {
  commit = { border = border_style },
  history = { diffPopup = { border = border_style } },
}

spec.config = function(opts)
  require("tinygit").setup(opts)
  Utils.keymap.set_maps(maps)
end

PicoPack.register(spec)
