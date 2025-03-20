--------------
--  editor  --
--------------
-- use system clipboard
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
-- default tab size
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
-- use spaces instead of tabs
vim.opt.expandtab = true
-- smart indent
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
-- presistent undo
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
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
-- symbols
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
-- disable modeline
vim.opt.modeline = false
--------------
--  others  --
--------------
-- windows powershell
if KurisuNya.utils.is_windows() then
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
