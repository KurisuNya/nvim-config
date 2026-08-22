Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "odin" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "ols" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "odinfmt", filetypes = { "odin" } },
  } },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function() vim.lsp.enable("ols") end)
