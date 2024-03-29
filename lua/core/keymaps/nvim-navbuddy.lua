local M = {}
M.keymap_list = {
	["<esc>"] = require("nvim-navbuddy.actions").close(), -- Close and cursor to original location
	["q"] = require("nvim-navbuddy.actions").close(),
	["<leader>S"] = require("nvim-navbuddy.actions").close(),
	["j"] = require("nvim-navbuddy.actions").next_sibling(), -- down
	["k"] = require("nvim-navbuddy.actions").previous_sibling(), -- up
	["h"] = require("nvim-navbuddy.actions").parent(), -- Move to left panel
	["l"] = require("nvim-navbuddy.actions").children(), -- Move to right panel
	["<down>"] = require("nvim-navbuddy.actions").next_sibling(), -- down
	["<up>"] = require("nvim-navbuddy.actions").previous_sibling(), -- up
	["<left>"] = require("nvim-navbuddy.actions").parent(), -- Move to left panel
	["<right>"] = require("nvim-navbuddy.actions").children(), -- Move to right panel
	["<enter>"] = require("nvim-navbuddy.actions").select(), -- Goto selected symbol
	["gr"] = require("nvim-navbuddy.actions").root(), -- Move to first panel
	["r"] = require("nvim-navbuddy.actions").rename(), -- Rename currently focused symbol
	["d"] = require("nvim-navbuddy.actions").delete(), -- Delete scope
	["o"] = require("nvim-navbuddy.actions").select(),
	["gc"] = require("nvim-navbuddy.actions").comment(), -- Comment out current scope
	["v"] = require("nvim-navbuddy.actions").visual_scope(), -- Visual selection of scope
	["y"] = require("nvim-navbuddy.actions").yank_scope(), -- Yank the scope to system clipboard "+
	["<leader>j"] = require("nvim-navbuddy.actions").move_down(), -- Move focused node down
	["<leader>k"] = require("nvim-navbuddy.actions").move_up(), -- Move focused node up
	["s"] = require("nvim-navbuddy.actions").toggle_preview(), -- Show preview of current node
	["f"] = require("nvim-navbuddy.actions").telescope({ -- Fuzzy finder at current level.
		layout_config = { -- All options that can be
			height = 0.60, -- passed to telescope.nvim's
			width = 0.60, -- default can be passed here.
			prompt_position = "top",
			preview_width = 0.50,
		},
		layout_strategy = "horizontal",
	}),
	["?"] = require("nvim-navbuddy.actions").help(), -- Open mappings help window
}
return M
