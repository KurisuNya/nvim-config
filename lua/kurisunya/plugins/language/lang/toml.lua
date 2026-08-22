Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "toml" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "taplo" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "taplo", filetypes = { "toml" } },
  } },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function() vim.lsp.enable("taplo") end)
