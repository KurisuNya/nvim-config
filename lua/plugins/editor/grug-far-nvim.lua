local M = {}
M.config = function()
	local keymaps = require("keymaps.plugins.grug-far-nvim").keymaps
	require("grug-far").setup({
		keymaps = keymaps,
	})
end
return M
