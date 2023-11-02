local status, nvim_picgo = pcall(require, "nvim-picgo")
if not status then
	return
end
nvim_picgo.setup({
	notice = "notify",
	image_name = false,
	debug = false,
})
