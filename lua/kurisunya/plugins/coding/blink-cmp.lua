---@type Manager.Spec
local spec = {
  {
    src = Manager.url.gh("saghen/blink.cmp"),
    version = vim.version.range("*"),
  },
  event = Manager.event.VeryLazy,
}

---@type Manager.Spec
local neotab_spec = {
  Manager.url.gh("kawre/neotab.nvim"),
  opts = {},
  config = function(opts) require("neotab").setup(opts) end,
}

---@type Manager.Spec
local luasnip_spec = {
  {
    src = Manager.url.gh("L3MON4D3/LuaSnip"),
    version = vim.version.range("2"),
  },
  build = "make install_jsregexp",
  dependencies = { Manager.url.gh("rafamadriz/friendly-snippets") },
  opts = { history = true, delete_check_events = "TextChanged" },
  config = function(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").setup(opts)
  end,
}

spec.dependencies = {
  Manager.url.gh("kawre/neotab.nvim"),
  {
    src = Manager.url.gh("L3MON4D3/LuaSnip"),
    version = vim.version.range("2"),
  },
}

spec.init = function()
  Utils.keymap.del("i", "<C-S>") -- default keymap for signature help
end

spec.opts = function()
  local opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-y>"] = { "select_and_accept", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "cancel", "fallback" },

      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    snippets = { preset = "luasnip" },
    signature = {
      enabled = true,
      window = { border = Config.border_style },
    },
    completion = {
      menu = { border = Config.border_style },
      accept = { auto_brackets = { enabled = false } },
      list = { selection = { preselect = false, auto_insert = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = Config.border_style },
      },
    },
    cmdline = {
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = { auto_show = true },
      },
    },
  }

  if Manager.have("lazydev.nvim") then
    Manager.load("lazydev.nvim")
    opts.sources = {
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
      },
    }
  end

  return opts
end

spec.config = function(opts) require("blink.cmp").setup(opts) end

Manager.add(neotab_spec)
Manager.add(luasnip_spec)
Manager.add(spec)
