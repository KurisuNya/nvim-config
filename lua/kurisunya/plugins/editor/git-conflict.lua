Manager.add({
  {
    src = Manager.url.gh("akinsho/git-conflict.nvim"),
    version = vim.version.range("*"),
  },
  opts = {
    disable_diagnostics = true,
    highlights = {
      current = "DiffText",
      incoming = "DiffAdd",
      ancestor = "DiffDelete",
    },
  },
  config = function(opts) require("git-conflict").setup(opts) end,
  event = Manager.event.VeryLazy,
})
