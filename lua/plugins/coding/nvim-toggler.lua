local M = {
	"nguyenvukhang/nvim-toggler",
	event = "VeryLazy",
}

M.keys = function()
	vim.keymap.set("n", "<leader>a", require("nvim-toggler").toggle, {
		noremap = true,
		silent = true,
		desc = "Word Meaning Toggle",
	})
end

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
