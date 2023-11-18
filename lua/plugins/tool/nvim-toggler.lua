local M = {}
M.config = function()
	require("nvim-toggler").setup({
		remove_default_keybinds = true,
		inverses = {
			["true"] = "false",
			["True"] = "False",
			["yes"] = "no",
			["on"] = "off",
			["left"] = "right",
			["up"] = "down",
			["enable"] = "disable",
			["!="] = "==",
			["next"] = "previous",
			["above"] = "below",
		},
	})
end
return M
