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
require("lazy").setup("plugins.plugins")
-------------------------
--                     --
--    plugin-config    --
--                     --
-------------------------
-- ui plugins
require("plugins.ui")
-- cmp plugins
require("plugins.cmp")
-- lsp plugins
require("plugins.lsp")
-- function plugins
require("plugins.tool")
