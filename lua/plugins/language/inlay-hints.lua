return {
	"MysticalDevil/inlay-hints.nvim",
	dependencies = {
		{
			"felpafel/inlay-hint.nvim",
			config = function()
				require("inlay-hint").setup()
			end,
		},
	},
	config = function()
		require("inlay-hints").setup()
	end,
	event = "VeryLazy",
}
