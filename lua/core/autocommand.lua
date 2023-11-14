-- 关闭新行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- 重新打开恢复光标
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("LastLoc", { clear = true }),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
-- 自动重载split
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = vim.api.nvim_create_augroup("ResizeSplit", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})
-- 使用q退出
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
-- 	pattern = {
-- 		"PlenaryTestPopup",
-- 		"help",
-- 		"lspinfo",
-- 		"man",
-- 		"notify",
-- 		"qf",
-- 		"query",
-- 		"spectre_panel",
-- 		"startuptime",
-- 		"tsplayground",
-- 		"neotest-output",
-- 		"checkhealth",
-- 		"neotest-summary",
-- 		"neotest-output-panel",
-- 	},
-- 	callback = function(event)
-- 		vim.bo[event.buf].buflisted = false
-- 		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
-- 	end,
-- })
-- 自动创建目录
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
-- 自动折行
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("WrapSpell", { clear = true }),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})
