PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "haskell" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "ormolu" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "ormolu", filetypes = { "haskell" } },
  } },
}, { extend = "custom.formatters" })

PicoPack.after_config("nvim-lspconfig", function() vim.lsp.enable("hls") end)
