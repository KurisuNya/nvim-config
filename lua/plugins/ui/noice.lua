local M = {}
M.config = function()
	local open_help = function(word)
		if vim.o.filetype == "noice" then
			vim.cmd.close()
		end
		vim.cmd.help(word)
	end
	local opts = {
		lsp = { progress = { enabled = false } },
		markdown = {
			hover = { ["|(%S-)|"] = open_help },
			open_link_keys = require("keymaps.plugins.noice").open_link_key,
		},
		presets = { bottom_search = true, lsp_doc_border = true },
		views = {
			hover = {
				size = { width = "auto", height = "auto", max_height = 20, max_width = 75 },
			},
		},
	}
	require("noice").setup(opts)
end
return M
