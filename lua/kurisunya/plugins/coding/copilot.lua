---@type Manager.Spec
local spec = {
  Manager.url.gh("zbirenbaum/copilot.lua"),
  build = function() vim.cmd("Copilot auth") end,
  event = Manager.event.VeryLazy,
}

local mappings = {
  accept = "<C-CR>",
  accept_line = "<S-CR>",
}

spec.opts = {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = mappings,
  },
  panel = { enabled = false },
  filetypes = { markdown = true, yaml = true, help = true },
}

spec.config = function(opts) require("copilot").setup(opts) end

Manager.opts_extend("lualine.nvim", {
  custom = { hidden_lsp = { "copilot" } },
}, { extend = "custom.hidden_lsp" })

Manager.add(spec)
