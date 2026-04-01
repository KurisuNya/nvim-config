return {
	"saghen/blink.pairs",
	event = "VeryLazy",
	build = "cargo build --release",
	opts = {
		mappings = {
			enabled = true,
			cmdline = true,
		},
		highlights = {
			enabled = false,
			cmdline = false,
			matchparen = {
				enabled = false,
				cmdline = false,
			},
		},
	},
}
