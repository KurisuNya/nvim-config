---@type Manager.Spec
local spec = {
  Manager.url.gh("nvim-neotest/neotest"),
  dependencies = { Manager.url.gh("nvim-neotest/nvim-nio") },
  event = Manager.event.VeryLazy,
}

local maps = {
  {
    "n",
    "<leader>tt",
    function()
      require("neotest").run.run(vim.uv.cwd())
      require("neotest").summary.open()
    end,
    { desc = "Test All" },
  },
  {
    "n",
    "<leader>ts",
    function()
      require("neotest").run.stop()
      require("neotest").summary.close()
    end,
    { desc = "Test Stop" },
  },
  {
    "n",
    "<leader>z",
    function() require("neotest").summary.toggle() end,
    { desc = "Test Summary Toggle" },
  },
}
local filetype_maps = {
  ["neotest-summary"] = {
    { "n", "q", function() require("neotest").summary.close() end, { desc = "Close Summary" } },
  },
  ["neotest-output"] = {
    { "n", "q", function() vim.cmd("close") end, { desc = "Close Output" } },
  },
}

local mappings = {
  attach = "a",
  clear_marked = "M",
  clear_target = "T",
  debug = "d",
  debug_marked = "D",
  expand = "<CR>",
  expand_all = "e",
  help = "?",
  jumpto = "i",
  mark = "m",
  next_failed = "]",
  output = "o",
  prev_failed = "[",
  run = "r",
  run_marked = "R",
  short = "O",
  stop = "u",
  target = "t",
  watch = "w",
}

spec.opts = {
  adapters = {},
  floating = { border = Config.border_style },
  summary = {
    mappings = mappings,
    open = "botright vsplit | vertical resize 40",
  },
}

spec.config = function(opts)
  local adapters = {}
  for _, adapter in ipairs(opts.adapters) do
    if type(adapter) == "function" then
      table.insert(adapters, adapter())
    else
      table.insert(adapters, adapter)
    end
  end
  opts.adapters = adapters
  require("neotest").setup(opts)

  Utils.keymap.set_maps(maps)
  for filetype, map_list in pairs(filetype_maps) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function(ev) Utils.keymap.set_maps(map_list, { buffer = ev.buf }) end,
    })
  end
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = { "neotest-summary" },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
