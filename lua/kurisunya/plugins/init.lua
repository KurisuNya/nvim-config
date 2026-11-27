-- ┌─────────────┐
-- │ lazy notify │
-- └─────────────┘

local notifs = {}
local function temp(...) table.insert(notifs, vim.F.pack_len(...)) end

local orig = vim.notify
vim.notify = temp

local timer = assert(vim.uv.new_timer())
local check = assert(vim.uv.new_check())

local replay = function()
  timer:stop()
  check:stop()
  if vim.notify == temp then
    vim.notify = orig -- put back the original notify if needed
  end
  vim.schedule(function()
    ---@diagnostic disable-next-line: no-unknown
    for _, notif in ipairs(notifs) do
      vim.notify(vim.F.unpack_len(notif))
    end
  end)
end

-- wait till vim.notify has been replaced
check:start(function()
  if vim.notify ~= temp then
    replay()
  end
end)
-- or if it took more than 500ms, then something went wrong
timer:start(500, 0, replay)

-- ┌──────────┐
-- │ picopack │
-- └──────────┘

vim.pack.add({ "https://github.com/kurisunya/picopack.nvim" }, { confirm = false })
_G.PicoPack = require("picopack")

-- ┌─────────────┐
-- │ global deps │
-- └─────────────┘

require("kurisunya.plugins.deps")

-- ┌─────────────┐
-- │ colorscheme │
-- └─────────────┘

require("kurisunya.plugins.colorscheme.colorschemes")
require("kurisunya.plugins.colorscheme.tokyonight")
require("kurisunya.plugins.colorscheme.gruvbox-material")

-- ┌────────┐
-- │ editor │
-- └────────┘

require("kurisunya.plugins.editor.which-key")
require("kurisunya.plugins.editor.barbar")
require("kurisunya.plugins.editor.lualine")
require("kurisunya.plugins.editor.neo-tree")
require("kurisunya.plugins.editor.telescope")
require("kurisunya.plugins.editor.projections")
require("kurisunya.plugins.editor.toggleterm")
require("kurisunya.plugins.editor.grug-far")
require("kurisunya.plugins.editor.gitsigns")
require("kurisunya.plugins.editor.nvim-tinygit")
require("kurisunya.plugins.editor.diffview")
require("kurisunya.plugins.editor.git-conflict")
require("kurisunya.plugins.editor.noice")
require("kurisunya.plugins.editor.virt-column")
require("kurisunya.plugins.editor.quicker")
require("kurisunya.plugins.editor.snacks")
require("kurisunya.plugins.editor.hlsearch")
require("kurisunya.plugins.editor.numb")
require("kurisunya.plugins.editor.stickybuf")
if Utils.os.is_linux() then
  require("kurisunya.plugins.editor.fcitx")
  require("kurisunya.plugins.editor.suda")
end

-- ┌────────┐
-- │ coding │
-- └────────┘

require("kurisunya.plugins.coding.indent-o-matic")
require("kurisunya.plugins.coding.indent-blankline")
require("kurisunya.plugins.coding.blink-cmp")
require("kurisunya.plugins.coding.ts-comments")
require("kurisunya.plugins.coding.nvim-autopairs")
require("kurisunya.plugins.coding.nvim-ts-autotag")
require("kurisunya.plugins.coding.sniprun")
require("kurisunya.plugins.coding.leap")
require("kurisunya.plugins.coding.nvim-surround")
require("kurisunya.plugins.coding.treesj")
require("kurisunya.plugins.coding.nvim-toggler")
require("kurisunya.plugins.coding.vim-illuminate")
require("kurisunya.plugins.coding.todo-comments")
require("kurisunya.plugins.coding.nvim-colorizer")
if Config.use_ai then
  require("kurisunya.plugins.coding.copilot")
  require("kurisunya.plugins.coding.sidekick")
end

-- ┌──────────┐
-- │ language │
-- └──────────┘

require("kurisunya.plugins.language.mason")
require("kurisunya.plugins.language.treesitter")
require("kurisunya.plugins.language.lspconfig")
require("kurisunya.plugins.language.lspsaga")
require("kurisunya.plugins.language.nvim-gtd")
require("kurisunya.plugins.language.conform")
require("kurisunya.plugins.language.nvim-dap")
require("kurisunya.plugins.language.neotest")

require("kurisunya.plugins.language.lang.misc")
require("kurisunya.plugins.language.lang.c")
require("kurisunya.plugins.language.lang.c3")
require("kurisunya.plugins.language.lang.haskell")
require("kurisunya.plugins.language.lang.lua")
require("kurisunya.plugins.language.lang.markdown")
require("kurisunya.plugins.language.lang.odin")
require("kurisunya.plugins.language.lang.python")
require("kurisunya.plugins.language.lang.teal")
require("kurisunya.plugins.language.lang.toml")
require("kurisunya.plugins.language.lang.xml")
require("kurisunya.plugins.language.lang.zig")

PicoPack.start()
if Config.clean_unmanaged_plugins then
  PicoPack.clean()
end
