PluginVars.colorscheme_specs = {}

return {
	"KurisuNya/colorschemes.nvim",
	opts = function()
		return {
			create_commands = true,
			default_colorscheme = Config.default_colorscheme,
			specs = PluginVars.colorscheme_specs,
		}
	end,
	lazy = false,
	priority = 10000,
}
