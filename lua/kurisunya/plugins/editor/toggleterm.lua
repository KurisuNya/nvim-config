---@type Manager.Spec
local spec = {
  Manager.url.gh("akinsho/toggleterm.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  { "n", "<leader>1", "<CMD>ToggleTerm 1<CR>", { desc = "Terminal 1" } },
  { "n", "<leader>2", "<CMD>ToggleTerm 2<CR>", { desc = "Terminal 2" } },
  { "n", "<leader>3", "<CMD>ToggleTerm 3<CR>", { desc = "Terminal 3" } },
  { "n", "<leader>4", "<CMD>ToggleTerm 4<CR>", { desc = "Terminal 4" } },
}
local open_key = [[<C-\>]]

local border_style = Config.border_style
local fallback = Config.border_style_fallback
border_style = border_style == "none" and fallback or border_style

spec.opts = function()
  return {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return 60
      end
    end,
    open_mapping = open_key,
    direction = "float",
    highlights = { FloatBorder = { guifg = Utils.highlight.get_color("FloatBorder").fg } },
    float_opts = { border = border_style },
    on_create = function(term)
      term.display_name = "Terminal " .. term.id
      require("toggleterm.ui").update_float(term)
    end,
  }
end

spec.config = function(opts)
  require("toggleterm").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.add(spec)
