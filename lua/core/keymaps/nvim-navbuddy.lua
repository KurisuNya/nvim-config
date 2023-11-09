---------------------
--  nvim-navbuddy  --
---------------------
local status, nvim_navbuddy_actions = pcall(require, "nvim-navbuddy.actions")
if not status then
	return
end
local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>S", "<Cmd>Navbuddy<CR>", opts)
local M = {
	["<esc>"] = nvim_navbuddy_actions.close(), -- Close and cursor to original location
	["q"] = nvim_navbuddy_actions.close(),
	["j"] = nvim_navbuddy_actions.next_sibling(), -- down
	["k"] = nvim_navbuddy_actions.previous_sibling(), -- up
	["h"] = nvim_navbuddy_actions.parent(), -- Move to left panel
	["l"] = nvim_navbuddy_actions.children(), -- Move to right panel
	["<down>"] = nvim_navbuddy_actions.next_sibling(), -- down
	["<up>"] = nvim_navbuddy_actions.previous_sibling(), -- up
	["<left>"] = nvim_navbuddy_actions.parent(), -- Move to left panel
	["<right>"] = nvim_navbuddy_actions.children(), -- Move to right panel
	["<enter>"] = nvim_navbuddy_actions.select(), -- Goto selected symbol
	["gr"] = nvim_navbuddy_actions.root(), -- Move to first panel
	["r"] = nvim_navbuddy_actions.rename(), -- Rename currently focused symbol
	["d"] = nvim_navbuddy_actions.delete(), -- Delete scope
	["o"] = nvim_navbuddy_actions.select(),
	["gc"] = nvim_navbuddy_actions.comment(), -- Comment out current scope
	["v"] = nvim_navbuddy_actions.visual_scope(), -- Visual selection of scope
	["y"] = nvim_navbuddy_actions.yank_scope(), -- Yank the scope to system clipboard "+
	["<leader>j"] = nvim_navbuddy_actions.move_down(), -- Move focused node down
	["<leader>k"] = nvim_navbuddy_actions.move_up(), -- Move focused node up
	["s"] = nvim_navbuddy_actions.toggle_preview(), -- Show preview of current node
	["f"] = nvim_navbuddy_actions.telescope({ -- Fuzzy finder at current level.
		layout_config = { -- All options that can be
			height = 0.60, -- passed to telescope.nvim's
			width = 0.60, -- default can be passed here.
			prompt_position = "top",
			preview_width = 0.50,
		},
		layout_strategy = "horizontal",
	}),
	["?"] = nvim_navbuddy_actions.help(), -- Open mappings help window
}
return M
