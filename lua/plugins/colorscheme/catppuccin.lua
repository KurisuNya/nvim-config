return {
	"catppuccin/nvim",
	name = "catppuccin",
	init = function()
		PluginVars.insert(PluginVars.colorscheme_specs, {
			colorschemes = {
				"catppuccin-latte",
				"catppuccin-frappe",
				"catppuccin-macchiato",
				"catppuccin-mocha",
			},
			activate = function(name)
				vim.cmd.colorscheme(name)
				if Utils.plugin_exists("nvim-gtd") then
					require("gtd").setup_highlights()
				end
			end,
		})
	end,
}
