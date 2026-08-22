---@type Manager.Spec
local spec = {
  Manager.url.gh("folke/sidekick.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    { "n", "t", "i", "x" },
    "<C-/>",
    function() require("sidekick.cli").toggle({ name = Config.ai_cli, focus = true }) end,
    { desc = "Sidekick CLI Toggle " },
  },
  {
    { "x", "n" },
    "<leader>st",
    function() require("sidekick.cli").send({ name = Config.ai_cli, msg = "{this}" }) end,
    { desc = "Sidekick Send This" },
  },
  {
    "n",
    "<leader>sf",
    function() require("sidekick.cli").send({ name = Config.ai_cli, msg = "{file}" }) end,
    { desc = "Sidekick Send File" },
  },
  {
    "x",
    "<leader>sv",
    function() require("sidekick.cli").send({ name = Config.ai_cli, msg = "{selection}" }) end,
    { desc = "Sidekick Send Selection" },
  },
}

local mappings = {
  buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
  files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
  prompt = false,
  stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
  hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
  hide_ctrl_q = false,
  hide_ctrl_dot = false,
  hide_ctrl_z = false,
  nav_left = { "<c-left>", "nav_left", expr = true, desc = "navigate to the left window" },
  nav_down = { "<c-down>", "nav_down", expr = true, desc = "navigate to the below window" },
  nav_up = { "<c-up>", "nav_up", expr = true, desc = "navigate to the above window" },
  nav_right = { "<c-right>", "nav_right", expr = true, desc = "navigate to the right window" },
}

spec.opts = {
  nes = { enabled = false },
  cli = {
    mux = { backend = "tmux", enabled = true },
    win = { keys = mappings },
  },
}

spec.config = function(opts)
  require("sidekick").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = { "sidekick_terminal" },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
