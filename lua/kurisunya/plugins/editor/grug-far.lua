---@type Manager.Spec
local spec = {
  Manager.url.gh("MagicDuck/grug-far.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    { "n", "x" },
    "<leader>R",
    function()
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      local prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil }
      require("grug-far").open({ transient = true, prefills = prefills })
    end,
    { desc = "Search and Replace" },
  },
}
local mappings = { close = { n = "q" } }

spec.opts = { keymaps = mappings }

spec.config = function(opts)
  require("grug-far").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = { "grug-far" },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
