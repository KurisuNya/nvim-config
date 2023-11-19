---------------
--  options  --
---------------
-- 使用系统剪切板
vim.opt.clipboard:append("unnamedplus")
-- 光标周围保留8行8列
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- 使用相对行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 高亮所在行
vim.opt.cursorline = true
-- 显示左侧图标指示列
vim.opt.signcolumn = "yes"
-- 显示右侧参考线
vim.opt.colorcolumn = "100"
-- Tab长度
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
-- 空格替代tab
vim.opt.expandtab = true
-- 新行对齐当前行
vim.opt.autoindent = true
vim.opt.smartindent = true
-- 搜索智能大小写
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- 边输入边搜索
vim.opt.incsearch = true
-- 禁止折行
vim.opt.wrap = false
-- 鼠标支持
vim.opt.mouse = "a"
-- 禁止创建备份文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- 更小更新时间
vim.opt.updatetime = 300
-- 分屏方向
vim.opt.splitbelow = true
vim.opt.splitright = true
-- 永远显示tabline
vim.opt.showtabline = 2
-- 当文件被外部程序修改时，自动加载
vim.opt.autoread = true
-- diff 使用对角线
vim.opt.fillchars:append({ diff = "╱" })
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
