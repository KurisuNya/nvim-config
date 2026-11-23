PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "lua" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "lua-language-server", "stylua" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "stylua", filetypes = { "lua" } },
  } },
}, { extend = "custom.formatters" })

PicoPack.after_config("nvim-lspconfig", function()
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

PicoPack.register({
  PicoPack.url.gh("folke/lazydev.nvim"),
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  config = function(opts) require("lazydev").setup(opts) end,
  filetype = "lua",
})
