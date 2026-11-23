---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("KurisuNya/noice.nvim"),
  dependencies = { PicoPack.url.gh("MunifTanjim/nui.nvim") },
  event = PicoPack.event.VeryLazy,
}

local maps = function()
  local m = {
    { "n", "<leader>fm", "<CMD>Noice telescope<CR>", { desc = "Telescope Message" } },
  }
  return PicoPack.is_registered("telescope.nvim") and m or {}
end
local open_key = "H"

local border_style = Config.border_style
local fallback = Config.border_style_fallback
border_style = border_style == "none" and fallback or border_style

local open_help = function(word)
  if vim.o.filetype == "noice" then
    vim.cmd.close()
  end
  vim.cmd.help(word)
end

spec.opts = {
  lsp = {
    signature = { enabled = false },
  },
  markdown = {
    hover = { ["|(%S-)|"] = open_help },
    open_keys = open_key,
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    long_message_to_split = true,
  },
  views = {
    hover = {
      size = { width = "auto", height = "auto", max_height = 20, max_width = 75 },
      border = { style = Config.border_style },
    },
    popup = { border = { style = border_style } },
    cmdline_popup = { border = { style = border_style } },
    cmdline_input = { border = { style = border_style } },
    confirm = { border = { style = border_style } },
  },
}

spec.config = function(opts)
  require("noice").setup(opts)
  Utils.keymap.set_maps(maps())
end

PicoPack.register(spec)
