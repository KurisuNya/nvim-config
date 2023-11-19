local M = {}
M.config = function()
	require("git-conflict").setup({
		default_mappings = require("core.keymaps.git-conflict").keymap_list,
		default_commands = true, -- disable commands created by this plugin
	})
end
return M
