local M = {}
M.config = function()
	local open_help = function(word)
		if vim.o.filetype == "noice" then
			vim.cmd.close()
		end
		vim.cmd.help(word)
	end
	local opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			progress = { enabled = false },
		},
		markdown = {
			hover = {
				["|(%S-)|"] = open_help,
				["%[.-%]%((http%S-)%)"] = require("noice.util").open,
			},
			open_link_keys = require("keymaps.plugins.noice").open_link_key,
		},
		presets = {
			bottom_search = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
		views = {
			hover = {
				size = { width = "auto", height = "auto", max_height = 20, max_width = 75 },
				win_options = { wrap = true, linebreak = true },
			},
		},
	}
	require("noice").setup(opts)
end
return M
