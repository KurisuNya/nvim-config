return {
	"Shatur/neovim-ayu",
	init = function()
		PluginVars.insert(PluginVars.colorscheme_specs, {
			colorschemes = {
				"ayu-dark",
				"ayu-light",
				"ayu-mirage",
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
