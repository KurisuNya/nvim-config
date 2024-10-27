local M = {}
local opts = { noremap = true, silent = true }
local function extend_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
M.keymaps = {
	finder = {
		key = "gr",
		cmd = "<Cmd>Lspsaga finder<CR>",
		mode = "n",
		opts = extend_desc("Lsp Find Reference"),
	},
	rename = {
		key = "<leader>rn",
		cmd = "<Cmd>Lspsaga rename<CR>",
		mode = "n",
		opts = extend_desc("Lsp Rename"),
	},
	code_action = {
		key = "<leader>ca",
		cmd = "<Cmd>Lspsaga code_action<CR>",
		mode = "n",
		opts = extend_desc("Lsp Code Action"),
	},
	diagnostics = {
		key = "<leader>D",
		cmd = "<Cmd>Lspsaga show_line_diagnostics<CR>",
		mode = "n",
		opts = extend_desc("Lsp Line Diagnostic"),
	},
	diagnostic_jump_prev = {
		key = "[d",
		cmd = "<Cmd>Lspsaga diagnostic_jump_prev<CR>",
		mode = "n",
		opts = extend_desc("Previous Lsp Diagnostic"),
	},
	diagnostic_jump_next = {
		key = "]d",
		cmd = "<Cmd>Lspsaga diagnostic_jump_next<CR>",
		mode = "n",
		opts = extend_desc("Next Lsp Diagnostic"),
	},
}
M.outline_keymap = {
	toggle_or_jump = "<Tab>",
	quit = { "<Esc>", "q" },
	jump = "<CR>",
}
M.finder_keymap = {
	toggle_or_open = "<CR>",
	quit = { "<Esc>", "q" },
}
M.code_action_keymap = {
	quit = { "<Esc>", "q" },
	exec = "<CR>",
}
return M
