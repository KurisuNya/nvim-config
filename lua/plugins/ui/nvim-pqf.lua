local M = {}
M.config = function()
	local icons = require("plugins.ui.icons").diagnostics
	require("pqf").setup({
		signs = {
			error = icons.Error,
			warning = icons.Warning,
			info = icons.Info,
			hint = icons.Hint,
		},
	})
end
return M
