local status, nvim_toggler = pcall(require, "nvim-toggler")
if not status then
	return
end
nvim_toggler.setup({
	remove_default_keybinds = true,
})
