local M = {}
M.mappings = function()
	local actions = require("nvim-navbuddy.actions")
	return {
		["esc"] = actions.close(),
		["q"] = actions.close(),
		["<leader>S"] = actions.close(),
		["j"] = actions.next_sibling(),
		["k"] = actions.previous_sibling(),
		["h"] = actions.parent(),
		["l"] = actions.children(),
		["<down>"] = actions.next_sibling(),
		["<up>"] = actions.previous_sibling(),
		["<left>"] = actions.parent(),
		["<right>"] = actions.children(),
		["<enter>"] = actions.select(),
		["gr"] = actions.root(),
		["r"] = actions.rename(),
		["d"] = actions.delete(),
		["o"] = actions.select(),
		["gc"] = actions.comment(),
		["v"] = actions.visual_scope(),
		["y"] = actions.yank_scope(),
		["<leader>j"] = actions.move_down(),
		["<leader>k"] = actions.move_up(),
		["s"] = actions.toggle_preview(),
		["f"] = actions.telescope({
			layout_config = {
				height = 0.60,
				width = 0.60,
				prompt_position = "top",
				preview_width = 0.50,
			},
			layout_strategy = "horizontal",
		}),
		["?"] = actions.help(),
	}
end
local opts = { noremap = true, silent = true }
local function extend_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
M.keymaps = {
	symbols = {
		key = "<leader>S",
		cmd = "<Cmd>Navbuddy<CR>",
		mode = "n",
		opts = extend_desc("Lsp Symbols Explorer"),
	},
}
return M
