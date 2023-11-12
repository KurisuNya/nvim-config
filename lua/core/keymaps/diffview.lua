----------------
--  diffview  --
----------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
_G._diffview = false
--打开差异视图
keymap.set("n", "<leader>vd", function()
	vim.cmd("DiffviewOpen")
	_G._diffview = true
end, opts)
--关闭差异视图
keymap.set("n", "<leader>cd", function()
	vim.cmd("DiffviewClose")
	_G._diffview = false
end, opts)
--打开文件历史视图
keymap.set("n", "<leader>hd", function()
	vim.cmd("DiffviewFileHistory")
	_G._diffview = true
end, opts)
