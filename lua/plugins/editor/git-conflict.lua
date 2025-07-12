return {
	"akinsho/git-conflict.nvim",
	version = "*",
	opts = {
		disable_diagnostics = true,
		highlights = {
			current = "DiffText",
			incoming = "DiffAdd",
			ancestor = "DiffDelete",
		},
	},
	event = "VeryLazy",
}
