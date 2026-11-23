---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("zbirenbaum/copilot.lua"),
  build = function() vim.cmd("Copilot auth") end,
  event = PicoPack.event.VeryLazy,
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

PicoPack.opts_extend("lualine.nvim", {
  custom = { hidden_lsp = { "copilot" } },
}, { extend = "custom.hidden_lsp" })

PicoPack.register(spec)
