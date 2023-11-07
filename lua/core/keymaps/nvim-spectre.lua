--------------------
--  nvim-spectre  --
--------------------
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>R", "<Cmd>lua require('spectre').open()<CR>", opts)
keymap.set("n", "<leader>rw", '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>', opts)
keymap.set("v", "<leader>rw", '<Cmd>lua require("spectre").open_visual()<CR>', opts)
local M = {
	["toggle_line"] = {
		map = "<Tab>",
		cmd = "<Cmd>lua require('spectre').toggle_line()<CR>",
		desc = "toggle current item",
	},
	["enter_file"] = {
		map = "<CR>",
		cmd = "<Cmd>lua require('spectre.actions').select_entry()<CR>",
		desc = "goto current file",
	},
	["run_current_replace"] = {
		map = "<leader>r",
		cmd = "<Cmd>lua require('spectre.actions').run_current_replace()<CR>",
		desc = "replace current line",
	},
	["run_replace"] = {
		map = "<leader>R",
		cmd = "<Cmd>lua require('spectre.actions').run_replace()<CR>",
		desc = "replace all",
	},
	["send_to_qf"] = {
		map = "<leader>f",
		cmd = "<Cmd>lua require('spectre.actions').send_to_qf()<CR>",
		desc = "send all item to quickfix",
	},
}
return M
