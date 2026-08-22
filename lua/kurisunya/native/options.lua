-- ┌────────────────┐
-- │ visual options │
-- └────────────────┘

-- line number
vim.o.number = true
vim.o.relativenumber = true
-- wrap
vim.o.wrap = false
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.linebreak = true
-- scroll
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- row
vim.o.cursorline = true
-- column
vim.o.signcolumn = "yes"
vim.opt.colorcolumn = { "80", "100" }
-- characters
vim.o.list = true
vim.opt.fillchars = Icons.fillchars
vim.opt.listchars = Icons.listchars
-- boarder
vim.o.winborder = Config.border_style
-- diagnostics
Utils.safecall.later(
  function()
    vim.diagnostic.config({
      virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
      signs = {
        priority = 9999,
        text = {
          [vim.diagnostic.severity.ERROR] = Icons.diagnostic.error,
          [vim.diagnostic.severity.WARN] = Icons.diagnostic.warning,
          [vim.diagnostic.severity.INFO] = Icons.diagnostic.info,
          [vim.diagnostic.severity.HINT] = Icons.diagnostic.hint,
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
  end
)

-- ┌────────────────┐
-- │ editor options │
-- └────────────────┘

-- encoding
vim.opt.fileencodings = { "ucs-bom", "utf-8", "cp936", "euc-cn", "euc-tw", "default", "latin1" }
-- indent
vim.o.autoindent = true
-- tab
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true
-- search
vim.o.ignorecase = true
vim.o.smartcase = true
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
-- visual block
vim.o.virtualedit = "block"
-- modeline
vim.o.modeline = false
-- swapfile
vim.o.swapfile = false
