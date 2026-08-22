Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "zig" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "zls" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "zls", filetypes = { "zig" } },
  } },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function() vim.lsp.enable("zls") end)
