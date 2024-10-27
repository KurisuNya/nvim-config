local icons = require("plugins.ui.icons")
vim.diagnostic.config({
	virtual_text = {
		spacing = 2,
		source = "if_many",
		prefix = "●",
	},
	signs = {
		text = {
			[1] = icons.diagnostics.Error,
			[2] = icons.diagnostics.Warning,
			[3] = icons.diagnostics.Info,
			[4] = icons.diagnostics.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
