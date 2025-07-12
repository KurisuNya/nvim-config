local activate = function(name)
	local name_style_map = {
		["material-darker"] = "darker",
		["material-lighter"] = "lighter",
		["material-oceanic"] = "oceanic",
		["material-palenight"] = "palenight",
		["material-deep-ocean"] = "deep ocean",
	}
	vim.g.material_style = name_style_map[name]
	vim.cmd.colorscheme(name)
	if Utils.plugin_exists("nvim-gtd") then
		require("gtd").setup_highlights()
	end
end

return {
	"marko-cerovac/material.nvim",
	init = function()
		PluginVars.insert(PluginVars.colorscheme_specs, {
			colorschemes = {
				"material-darker",
				"material-lighter",
				"material-oceanic",
				"material-palenight",
				"material-deep-ocean",
			},
			activate = activate,
		})
	end,
}
