---@type Manager.Spec
local spec = {
  Manager.url.gh("lukas-reineke/indent-blankline.nvim"),
  event = Manager.event.VeryLazy,
}

spec.opts = {
  indent = {
    char = "▎",
    tab_char = "▎",
  },
  scope = {
    include = {
      node_type = {
        all = {
          "return_statement",
          "table_constructor",
        },
      },
    },
  },
}

spec.config = function(opts) require("ibl").setup(opts) end

Manager.add(spec)
