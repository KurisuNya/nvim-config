return {
	"catgoose/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			options = {
				parsers = {
					names = { enable = false },
					hex = {
						enable = true,
						rgb = false, -- #RGB
						rgba = false, -- #RGBA
						rrggbb = true, -- #RRGGBB
						rrggbbaa = true, -- #RRGGBBAA
						aarrggbb = false, -- 0xAARRGGBB
					},
				},
			},
		})
	end,
	event = "VeryLazy",
}
