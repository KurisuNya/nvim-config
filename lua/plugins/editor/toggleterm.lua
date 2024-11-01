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
		open_mapping = require("keymaps.plugins.toggleterm").toggle_everywhere,
		direction = "float",
		highlights = {
			FloatBorder = {
				guifg = KurisuNya.utils.get_hl_color("FloatBorder", "fg#"),
			},
		},
		float_opts = { border = "rounded" },
		on_create = function(term)
			term.display_name = "Terminal " .. term.id
			require("toggleterm.ui").update_float(term)
		end,
	})
end
return M
