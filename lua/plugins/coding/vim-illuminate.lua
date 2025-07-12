return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({ disable_keymaps = false })
	end,
	event = "VeryLazy",
}
