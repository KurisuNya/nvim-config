local status, nvim_colorizer = pcall(require, "colorizer")
if not status then
	return
end
vim.opt.termguicolors = true
nvim_colorizer.setup()
