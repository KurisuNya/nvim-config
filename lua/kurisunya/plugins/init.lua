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
require("kurisunya.plugins.coding.ts-comment")
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
require("kurisunya.plugins.language.lang.haskell")
require("kurisunya.plugins.language.lang.lua")
require("kurisunya.plugins.language.lang.markdown")
require("kurisunya.plugins.language.lang.odin")
require("kurisunya.plugins.language.lang.python")
require("kurisunya.plugins.language.lang.toml")
require("kurisunya.plugins.language.lang.xml")
require("kurisunya.plugins.language.lang.zig")

Manager.load_all()
