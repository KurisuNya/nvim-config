PicoPack.opts_extend("mason.nvim", {
  ensure_installed = { "typos-lsp", "prettierd" },
}, { extend = "ensure_installed" })

local filetypes = { "css", "scss", "html", "json", "jsonc", "yaml" }
local src = debug.getinfo(1, "S").source
local this_dir = src:sub(1, 1) == "@" and vim.fn.fnamemodify(src:sub(2), ":h") or nil
local cfg_path = vim.fs.joinpath(this_dir, "prettier.json")
local cfg = { env = { PRETTIERD_DEFAULT_CONFIG = cfg_path } }
PicoPack.opts_extend("conform.nvim", {
  custom = { formatters = {
    { "prettierd", filetypes = filetypes, config = cfg },
  } },
}, { extend = "custom.formatters" })

PicoPack.opts_extend("lualine.nvim", {
  custom = { hidden_lsp = { "typos_lsp" } },
}, { extend = "custom.hidden_lsp" })

PicoPack.after_config("nvim-lspconfig", function() vim.lsp.enable("typos_lsp") end)
