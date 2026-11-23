---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("folke/todo-comments.nvim"),
  event = PicoPack.event.VeryLazy,
  dependencies = { PicoPack.url.gh("nvim-lua/plenary.nvim") },
}

local maps = {
  { "n", "<leader>td", "<CMD>TodoQuickFix<CR>", { desc = "TODO List" } },
}

spec.opts = {}

spec.config = function(opts)
  require("todo-comments").setup(opts)
  Utils.keymap.set_maps(maps)
end

PicoPack.register(spec)
