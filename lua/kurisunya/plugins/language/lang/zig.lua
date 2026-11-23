PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "zig" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "zls" },
}, { extend = "ensure_installed" })

PicoPack.after_config("nvim-lspconfig", function() vim.lsp.enable("zls") end)
