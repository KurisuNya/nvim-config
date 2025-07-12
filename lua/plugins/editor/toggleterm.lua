local M = {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
}

M.keys = {
	{
		"<leader>vt",
		"<CMD>ToggleTerm direction=vertical<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Vertical Terminal",
	},
	{
		"<leader>ht",
		"<CMD>ToggleTerm direction=horizontal<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Horizontal Terminal",
	},
	{
		"<leader>1",
		"<CMD>ToggleTerm 1<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 1",
	},
	{
		"<leader>2",
		"<CMD>ToggleTerm 2<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 2",
	},
	{
		"<leader>3",
		"<CMD>ToggleTerm 3<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 3",
	},
	{
		"<leader>4",
		"<CMD>ToggleTerm 4<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Terminal 4",
	},
}
local open_mapping = [[<C-\>]]

M.config = function()
	local border_style = Config.border_style
	local fallback = Config.border_style_fallback
	border_style = border_style == "none" and fallback or border_style

	require("toggleterm").setup({
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return 60
			end
		end,
		open_mapping = open_mapping,
		direction = "float",
		highlights = { FloatBorder = { guifg = Utils.get_hl_color("FloatBorder", "fg#") } },
		float_opts = { border = border_style },
		on_create = function(term)
			term.display_name = "Terminal " .. term.id
			require("toggleterm.ui").update_float(term)
		end,
	})
end

return M
