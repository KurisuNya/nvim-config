-- check if need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = KurisuNya.utils.create_augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- disable auto comment
vim.api.nvim_create_autocmd("FileType", {
	group = KurisuNya.utils.create_augroup("disable_auto_comment"),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = KurisuNya.utils.create_augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank({ timeout = 400 })
	end,
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = KurisuNya.utils.create_augroup("restore_cursor"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local line_count = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- q to close
vim.api.nvim_create_autocmd("FileType", {
	group = KurisuNya.utils.create_augroup("close_with_q"),
	pattern = KurisuNya.config.q_close_filetypes,
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- auto resize split
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = KurisuNya.utils.create_augroup("resize_split"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- auto create dir
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = KurisuNya.utils.create_augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- auto wrap
vim.api.nvim_create_autocmd("FileType", {
	group = KurisuNya.utils.create_augroup("wrap_spell"),
	pattern = KurisuNya.config.wrap_spell_filetypes,
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- windows auto switch input method
if KurisuNya.utils.is_windows() and vim.fn.executable("im-select") == 1 then
	local im_english = "im-select 1033"
	local im_chinese = "im-select 2052"
	vim.api.nvim_command("autocmd VimEnter * :silent :!" .. im_english)
	vim.api.nvim_command("autocmd InsertEnter * :silent :!" .. im_chinese)
	vim.api.nvim_command("autocmd InsertLeave * :silent :!" .. im_english)
	vim.api.nvim_command("autocmd VimLeave * :silent :!" .. im_chinese)
end
