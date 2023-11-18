local M = {}
M.keys = function()
	local spectre = require("spectre")
	vim.keymap.set("n", "<leader>R", spectre.open, {
		noremap = true,
		silent = true,
		desc = "Search Replace",
	})
	vim.keymap.set("n", "<leader>rw", function()
		spectre.open_visual({ select_word = true })
	end, {
		noremap = true,
		silent = true,
		desc = "Replace Word",
	})
	vim.keymap.set("x", "<leader>rw", spectre.open_visual, {
		noremap = true,
		silent = true,
		desc = "Replace Word",
	})
end

M.keymap_list = {
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
