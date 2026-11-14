vim.api.nvim_create_autocmd("BufWinEnter", {
  group = Utils.autocmd.new_group("teal_win_options"),
  pattern = "*.tl",
  callback = function() vim.wo[0][0].colorcolumn = "88" end,
})

Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "teal" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "teal-language-server" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = {
    formatters = {
      {
        "cerulean",
        filetypes = { "teal" },
        config = {
          command = vim.fn.expand("~/.luarocks/bin/ceru"),
          args = { "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function() vim.lsp.enable("teal_ls") end)
