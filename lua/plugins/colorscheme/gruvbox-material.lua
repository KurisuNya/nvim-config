local active = function(name)
	local background = name:match("dark") and "dark" or "light"
	local contrast = name:match("soft") and "soft" or name:match("hard") and "hard" or "medium"
	vim.opt.background = background
	vim.g.gruvbox_material_background = contrast
	vim.cmd.colorscheme("gruvbox-material")
end

return {
	"sainnhe/gruvbox-material",
	init = function()
		PluginVars.insert(PluginVars.colorscheme_specs, {
			colorschemes = {
				"gruvbox-dark-soft",
				"gruvbox-dark-medium",
				"gruvbox-dark-hard",
				"gruvbox-light-soft",
				"gruvbox-light-medium",
				"gruvbox-light-hard",
			},
			activate = active,
		})
	end,
}
