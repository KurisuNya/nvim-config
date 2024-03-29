local M = {}
M.config = function()
	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return 60
			end
		end,
		open_mapping = require("core.keymaps.toggleterm").toggle_everywhere,
		direction = "float",
		highlights = { FloatBorder = { guifg = "#29a4bd" } },
		float_opts = { border = "rounded" },
	})
end
return M
