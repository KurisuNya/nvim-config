---@type Manager.Spec
local spec = {
  Manager.url.gh("romgrk/barbar.nvim"),
  dependencies = { Manager.url.gh("nvim-mini/mini.icons") },
  event = { "BufReadPre", "BufNewFile" },
}

local maps = {
  { "n", "<A-Right>", "<CMD>BufferNext<CR>", { desc = "Buffer Next" } },
  { "n", "<A-Left>", "<CMD>BufferPrevious<CR>", { desc = "Buffer Previous" } },
  { "n", "<A-,>", "<CMD>BufferMovePrevious<CR>", { desc = "Buffer Move to Previous" } },
  { "n", "<A-.>", "<CMD>BufferMoveNext<CR>", { desc = "Buffer Move to Next" } },
  { "n", "<A-s>", "<CMD>BufferOrderByDirectory<CR>", { desc = "Buffer Sort by Dir" } },
  { "n", "<A-p>", "<CMD>BufferPin<CR>", { desc = "Buffer Pin" } },
  { "n", "<A-q>", "<CMD>BufferClose<CR>", { desc = "Buffer Close" } },
  { "n", "<A-Q>", "<CMD>BufferCloseAllButPinned<CR>", { desc = "Buffer Close Except Pinned" } },
}

spec.init = function()
  vim.o.showtabline = 0
  vim.g.barbar_auto_setup = false
end

spec.opts = function()
  local opts = {
    animation = false,
    tabpages = false,
    highlight_visible = true,
    modified = { button = Icons.git.modified },
    focus_on_close = "left",
    icons = {
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = Icons.diagnostic.error },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = Icons.diagnostic.warning },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = Icons.diagnostic.info },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = Icons.diagnostic.hint },
      },
      separator_at_end = false,
      inactive = { separator = { left = " ", right = "" } },
      pinned = { button = Icons.misc.pinned, filename = true },
    },
    maximum_padding = 1,
    minimum_padding = 1,
    no_name_title = "Empty",
    sidebar_filetypes = {},
  }
  if Manager.have("neo-tree.nvim") then
    opts.sidebar_filetypes["neo-tree"] = {
      event = "BufWipeout",
      text = "FILE EXPLORER",
    }
  end
  return opts
end

spec.config = function(opts)
  require("barbar").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.opts_extend("diffview.nvim", {
  custom = {
    view_opened_hooks = { function() Utils.keymap.del_maps(maps) end },
    view_close_hooks = { function() Utils.keymap.set_maps(maps) end },
  },
}, { extend = { "custom.view_opened_hooks", "custom.view_close_hooks" } })

Manager.add(spec)
