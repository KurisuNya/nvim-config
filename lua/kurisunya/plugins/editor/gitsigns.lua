---@type Manager.Spec
local spec = {
  Manager.url.gh("lewis6991/gitsigns.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = function()
  local gs = package.loaded.gitsigns
  return {
    { "n", "]h", gs.next_hunk, { desc = "Git Hunk Next" } },
    { "n", "[h", gs.prev_hunk, { desc = "Git Hunk Previous" } },
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
