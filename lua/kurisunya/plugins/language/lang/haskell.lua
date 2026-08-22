Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "haskell" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "ormolu" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "ormolu", filetypes = { "haskell" } },
  } },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function() vim.lsp.enable("hls") end)
