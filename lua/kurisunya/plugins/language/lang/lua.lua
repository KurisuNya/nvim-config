Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "lua" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "lua-language-server", "stylua" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "stylua", filetypes = { "lua" } },
  } },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        codeLens = { enable = true },
        completion = { callSnippet = "Replace" },
        doc = { privateName = { "^_" } },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end)

Manager.add({
  Manager.url.gh("folke/lazydev.nvim"),
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  config = function(opts) require("lazydev").setup(opts) end,
  filetype = "lua",
})
