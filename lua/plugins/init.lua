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
require("lazy.core.config").defaults.defaults.lazy = true
require("lazy").setup({
	--------------------------
	-- normal dependencies --
	--------------------------
	-- utils
	{ "nvim-lua/plenary.nvim" },
	{ "kevinhwang91/promise-async" },
	-- ui dependence
	{
		"nvim-tree/nvim-web-devicons",
		opts = { color_icons = true, default = true, strict = true },
	},
	{ "onsails/lspkind.nvim" },
	{ "MunifTanjim/nui.nvim" },

	{ require("core.colorscheme").colorscheme_plugin },
	{ require("plugins.ui") },
	{ require("plugins.cmp") },
	{ require("plugins.lsp") },
	{ require("plugins.tool") },
})
