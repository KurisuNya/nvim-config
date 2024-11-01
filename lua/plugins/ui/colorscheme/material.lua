local M = {}
M.config = function(name)
	local name_style_map = {
		["material-darker"] = "darker",
		["material-lighter"] = "lighter",
		["material-oceanic"] = "oceanic",
		["material-palenight"] = "palenight",
		["material-deep-ocean"] = "deep ocean",
	}
	vim.g.material_style = name_style_map[name]
	vim.cmd.colorscheme(name)
end
return M
