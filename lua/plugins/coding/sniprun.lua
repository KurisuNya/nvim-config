return {
	"michaelb/sniprun",
	branch = "master",
	build = "sh install.sh",
	opts = {
		display = { "TempFloatingWindow" },
		borders = Config.border_style,
	},
	event = "VeryLazy",
}
