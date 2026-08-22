---@type Manager.Spec
local spec = {
  Manager.url.gh("folke/todo-comments.nvim"),
  event = Manager.event.VeryLazy,
  dependencies = { Manager.url.gh("nvim-lua/plenary.nvim") },
}

local maps = {
  { "n", "<leader>td", "<CMD>TodoQuickFix<CR>", { desc = "TODO List" } },
}

spec.opts = {}

spec.config = function(opts)
  require("todo-comments").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.add(spec)
