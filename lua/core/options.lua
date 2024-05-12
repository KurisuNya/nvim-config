--------------
--  editor  --
--------------
-- use system clipboard
vim.opt.clipboard:append("unnamedplus")
-- default tab size
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
-- use spaces instead of tabs
vim.opt.expandtab = true
-- smart indent
vim.opt.autoindent = true
vim.opt.smartindent = true
-- smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- disable swap, backup and writebackup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- split direction
vim.opt.splitbelow = true
vim.opt.splitright = true
-- auto read file when changed
vim.opt.autoread = true
-- mouse support
vim.opt.mouse = "a"
--------------
--  visual  --
--------------
-- 8 lines from the top/bottom when scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- highlight current line
vim.opt.cursorline = true
-- display sign column
vim.opt.signcolumn = "yes"
-- display line column
vim.opt.colorcolumn = "100"
-- no wrap
vim.opt.wrap = false
-- incremental search
vim.opt.incsearch = true
-- diff symbol
vim.opt.fillchars:append({ diff = "╱" })
-- disable modeline
vim.opt.modeline = false
--------------
--  others  --
--------------
-- windows powershell
if vim.loop.os_uname().sysname == "Windows_NT" then
	local powershell_options = {
		shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
		shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
		shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
		shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
		shellquote = "",
		shellxquote = "",
	}
	for option, value in pairs(powershell_options) do
		vim.opt[option] = value
	end
end
