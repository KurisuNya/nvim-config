PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "c3" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "c3-lsp" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("conform.nvim", {
  custom = {
    formatters = {
      {
        "c3fmt",
        filetypes = { "c3" },
        config = { command = "c3fmt", args = { "--in-place", "$FILENAME" }, stdin = false },
      },
    },
  },
}, { extend = "custom.formatters" })

PicoPack.after_config("nvim-lspconfig", function() vim.lsp.enable("c3_lsp") end)
