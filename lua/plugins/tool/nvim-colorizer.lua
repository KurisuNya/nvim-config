local nvim_colorizer_status, nvim_colorizer = pcall(require, "colorizer")
if not nvim_colorizer_status then
	return
end
vim.opt.termguicolors = true
nvim_colorizer.setup()
