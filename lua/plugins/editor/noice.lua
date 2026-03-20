local M = {
	"KurisuNya/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
}
M.keys = function()
	if Utils.plugin_exists("telescope.nvim") then
		vim.keymap.set("n", "<leader>fm", "<Cmd>Noice telescope<CR>", {
			silent = true,
			noremap = true,
			desc = "Find Message",
		})
	end
end
local open_key = "H"

M.config = function()
	local border_style = Config.border_style
	local fallback = Config.border_style_fallback
	border_style = border_style == "none" and fallback or border_style

	local open_help = function(word)
		if vim.o.filetype == "noice" then
			vim.cmd.close()
		end
		vim.cmd.help(word)
	end
	local opts = {
		lsp = {
			signature = { enabled = false },
		},
		markdown = {
			hover = { ["|(%S-)|"] = open_help },
			open_keys = open_key,
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			long_message_to_split = true,
		},
		views = {
			hover = {
				size = { width = "auto", height = "auto", max_height = 20, max_width = 75 },
				border = { style = Config.cmp_border_style },
			},
			popup = { border = { style = border_style } },
			cmdline_popup = { border = { style = border_style } },
			cmdline_input = { border = { style = border_style } },
			confirm = { border = { style = border_style } },
		},
	}

	if vim.o.filetype == "lazy" then
		vim.cmd([[messages clear]])
	end
	require("noice").setup(opts)
end

return M
