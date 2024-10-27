local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/KurisuNya/lazy.nvim.git",
		lazy_path,
	})
end
vim.opt.rtp:prepend(lazy_path)
require("lazy").setup({
	require("plugins.dependencies"),
	require("plugins.ui"),
	require("plugins.editor"),
	require("plugins.coding"),
	require("plugins.language"),
}, {
	defaults = {
		lazy = true,
	},
	ui = {
		custom_keys = {
			["<localleader>l"] = false,
			["<localleader>t"] = false,
		},
	},
})
