local M = {}
M.config = function()
	require("nvim-toggler").setup({
		remove_default_keybinds = true,
		inverses = KurisuNya.config.toggle_pairs,
	})
end
return M
