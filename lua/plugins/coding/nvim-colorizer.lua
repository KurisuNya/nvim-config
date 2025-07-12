return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				names = false,
				RGB = true,
				RGBA = true,
				RRGGBB = true,
				RRGGBBAA = true,
			},
		})
	end,
	event = "VeryLazy",
}
