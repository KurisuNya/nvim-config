--------------------
-- visual options --
--------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.opt.colorcolumn = { 80, 100 }
vim.opt.fillchars = Icons.fillchars
vim.diagnostic.config({
  virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
  signs = {
    text = {
      [1] = Icons.diagnostic.Error,
      [2] = Icons.diagnostic.Warning,
      [3] = Icons.diagnostic.Info,
      [4] = Icons.diagnostic.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.o.list = true
vim.opt.listchars = Icons.listchars

--------------------
-- editor options --
--------------------
-- encoding
vim.opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "euc-cn", "euc-tw", "default", "latin1" }
-- modeline
vim.o.modeline = false
-- scroll
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- tab
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true
-- search
vim.o.ignorecase = true
vim.o.smartcase = true
-- swap
vim.o.swapfile = false
-- split
vim.o.splitbelow = true
vim.o.splitright = true
-- undo
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200
-- clipboard
vim.opt.clipboard:append("unnamedplus")
if os.getenv("SSH_TTY") or os.getenv("USER") == "root" then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
-- fold
vim.o.foldlevel = 99
vim.o.foldtext = ""
