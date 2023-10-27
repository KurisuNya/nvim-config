---------------
--  options  --
---------------
-- 使用系统剪切板
vim.opt.clipboard:append("unnamedplus")
-- 光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 显示右侧参考线
vim.wo.colorcolumn = "100"
-- Tab长度
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索智能大小写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 边输入边搜索
vim.o.incsearch = true
-- 禁止折行
vim.wo.wrap = false
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- 更小更新时间
vim.o.updatetime = 300
-- 键盘快捷键连击时间
vim.o.timeout = true
vim.o.timeoutlen = 1000
-- 分屏方向
vim.o.splitbelow = true
vim.o.splitright = true
-- 补全显示10行
vim.o.pumheight = 10
-- 永远显示tabline
vim.o.showtabline = 2
-- 关闭vim模式提示
vim.o.showmode = false
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 命令行不显示
vim.opt.cmdheight = 0
-- 关闭新行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- 重新打开恢复光标
local lastplace = "silent! foldopen"
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.cmd(lastplace)
		end
	end,
})
