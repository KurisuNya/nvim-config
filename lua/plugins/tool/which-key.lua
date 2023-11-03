local status, which_key = pcall(require, "which-key")
if not status then
	return
end
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
which_key.setup({})
