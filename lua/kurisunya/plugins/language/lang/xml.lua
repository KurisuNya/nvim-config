PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "xml" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "xmlformatter" },
}, { extend = "ensure_installed" })

PicoPack.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "xmlformatter", filetypes = { "xml" } },
  } },
}, { extend = "custom.formatters" })
