--------------------
-- visual options --
--------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "88,100"
vim.opt.fillchars = Icons.fillchars
vim.diagnostic.config({
	virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
	signs = {
		text = {
			[1] = Icons.diagnostics.Error,
			[2] = Icons.diagnostics.Warning,
			[3] = Icons.diagnostics.Info,
			[4] = Icons.diagnostics.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

--------------------
-- editor options --
--------------------
-- scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- swap
vim.opt.swapfile = false
-- split
vim.opt.splitbelow = true
vim.opt.splitright = true
-- undo
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
-- diff
vim.opt.diffopt = { "internal", "filler", "closeoff", "linematch:60", "foldcolumn:0" }
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
vim.opt.foldlevel = 99
vim.opt.foldtext = ""
