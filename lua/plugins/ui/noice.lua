local M = {}
M.config = function()
	vim.opt.cmdheight = 0
	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		markdown = {
			hover = {
				["|(%S-)|"] = vim.cmd.help,
				["%[.-%]%((jdt%S-)%)"] = require("jdtls").open_classfile,
				["%[.-%]%((http%S-)%)"] = require("noice.util").open,
			},
			open_link_keys = "H",
		},
		presets = {
			bottom_search = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
		views = {
			hover = {
				size = {
					width = "auto",
					height = "auto",
					max_height = 20,
					max_width = 90,
				},
				win_options = {
					wrap = true,
					linebreak = true,
				},
			},
		},
	})
end
return M
