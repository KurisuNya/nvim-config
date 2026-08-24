---@type Manager.Spec
local spec = {
  Manager.url.gh("lewis6991/gitsigns.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = function()
  return {
    {
      "n",
      "]h",
      function() require("gitsigns").nav_hunk("next", { target = "all" }) end,
      { desc = "Next Git Hunk" },
    },
    {
      "n",
      "[h",
      function() require("gitsigns").nav_hunk("prev", { target = "all" }) end,
      { desc = "Previous Git Hunk" },
    },
  }
end

spec.opts = {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  current_line_blame = true,
  current_line_blame_formatter = "   <author_time:%Y-%m-%d>, <author> ∙ <summary>",
  preview_config = {
    border = Config.border_style,
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr) Utils.keymap.set_maps(maps(), { buffer = bufnr }) end,
}

spec.config = function(opts) require("gitsigns").setup(opts) end

Manager.add(spec)
