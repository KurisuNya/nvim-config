---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	require("git-conflict").setup({
		default_mappings = require("core.keymaps.git-conflict").keymap_list,
	})
end
return M
