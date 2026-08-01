local M = {
	"nguyenvukhang/nvim-toggler",
	event = "VeryLazy",
}

M.keys = {
	{
		"<leader>a",
		function()
			require("nvim-toggler").toggle()
		end,
		silent = true,
		desc = "Word Meaning Toggle",
	},
}

M.config = function()
	require("nvim-toggler").setup({
		remove_default_keybinds = true,
		inverses = {
			["true"] = "false",
			["True"] = "False",
			["TRUE"] = "FALSE",
			["yes"] = "no",
			["Yes"] = "No",
			["YES"] = "NO",
			["on"] = "off",
			["On"] = "Off",
			["ON"] = "OFF",
			["enable"] = "disable",
			["Enable"] = "Disable",
			["ENABLE"] = "DISABLE",
		},
	})
end

return M
