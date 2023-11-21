--------------------------------
--                            --
--    plugin-manager-setup    --
--                            --
--------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	--------------------------
	-- normal dependencies --
	--------------------------
	-- utils
	{ "nvim-lua/plenary.nvim" },
	{ "kevinhwang91/promise-async" },
	-- ui dependence
	{ "MunifTanjim/nui.nvim", lazy = false },
	{
		"nvim-tree/nvim-web-devicons",
		opts = { color_icons = true, default = true, strict = true },
	},

	{ require("core.colorscheme").colorscheme_plugin },
	{ require("plugins.ui") },
	{ require("plugins.cmp") },
	{ require("plugins.lsp") },
	{ require("plugins.tool") },
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
