PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "toml" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "taplo" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "taplo", filetypes = { "toml" } },
  } },
}, { extend = "custom.formatters" })

PicoPack.after_config("nvim-lspconfig", function() vim.lsp.enable("taplo") end)
