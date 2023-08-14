local nvim_toggler_status, nvim_toggler = pcall(require, "nvim-toggler")
if not nvim_toggler_status then
	return
end
nvim_toggler.setup()
