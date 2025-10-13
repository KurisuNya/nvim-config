return {
	"catgoose/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				names = false,
				RGB = false,
				RGBA = false,
				RRGGBB = true,
				RRGGBBAA = true,
			},
		})
	end,
	event = "VeryLazy",
}
