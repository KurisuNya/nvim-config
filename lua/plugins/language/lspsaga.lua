local M = {
	"nvimdev/lspsaga.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

local opts = { noremap = true, silent = true }
local function add_desc(desc)
	return vim.tbl_extend("force", { desc = desc }, opts)
end
local keymaps = {
	finder = {
		key = "gr",
		cmd = "<Cmd>Lspsaga finder<CR>",
		mode = "n",
		opts = add_desc("Lsp Find Reference"),
	},
	rename = {
		key = "<leader>rn",
		cmd = "<Cmd>Lspsaga rename<CR>",
		mode = "n",
		opts = add_desc("Lsp Rename"),
	},
	code_action = {
		key = "<leader>ca",
		cmd = "<Cmd>Lspsaga code_action<CR>",
		mode = "n",
		opts = add_desc("Lsp Code Action"),
	},
	diagnostics = {
		key = "<leader>D",
		cmd = "<Cmd>Lspsaga show_buf_diagnostics<CR>",
		mode = "n",
		opts = add_desc("Lsp Line Diagnostic"),
	},
	diagnostic_jump_prev = {
		key = "[d",
		cmd = "<Cmd>Lspsaga diagnostic_jump_prev<CR>",
		mode = "n",
		opts = add_desc("Previous Lsp Diagnostic"),
	},
	diagnostic_jump_next = {
		key = "]d",
		cmd = "<Cmd>Lspsaga diagnostic_jump_next<CR>",
		mode = "n",
		opts = add_desc("Next Lsp Diagnostic"),
	},
	diagnostic_prev_warn = {
		key = "[w",
		cmd = function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
		end,
		mode = "n",
		opts = add_desc("Previous Lsp Diagnostic(Warning)"),
	},
	diagnostic_next_warn = {
		key = "]w",
		cmd = function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
		end,
		mode = "n",
		opts = add_desc("Next Lsp Diagnostic(Warning)"),
	},
	diagnostic_prev_error = {
		key = "[e",
		cmd = function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end,
		mode = "n",
		opts = add_desc("Previous Lsp Diagnostic(Error)"),
	},
	diagnostic_next_error = {
		key = "]e",
		cmd = function()
			require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
		end,
		mode = "n",
		opts = add_desc("Next Lsp Diagnostic(Error)"),
	},
}

local finder_keymap = { toggle_or_open = "<CR>", quit = "q" }
local code_action_keymap = { quit = "q", exec = "<CR>" }
local outline_keymap = { toggle_or_jump = "<Tab>", quit = "q", jump = "<CR>" }

M.init = function()
	PluginVars.insert(PluginVars.projections_close_filetypes, "sagaoutline")
end

M.keys = {
	{
		"<leader>z",
		"<Cmd>Lspsaga outline<CR>",
		desc = "Outline Toggle",
	},
}

M.config = function()
	require("lspsaga").setup({
		symbol_in_winbar = { enable = false },
		lightbulb = { enable = false },
		ui = {
			border = Config.border_style,
			expand = Icons.ui.ArrowClose,
			collapse = Icons.ui.ArrowOpen,
			lines = { "└", "├", "│", "─", "┌" },
		},
		rename = { in_select = false, auto_save = true },
		implement = { enable = true, sign = false },
		code_action = { keys = code_action_keymap },
		finder = { keys = finder_keymap },
		outline = { keys = outline_keymap },
	})

	Utils.lsp_keymap_set_by_method("textDocument/codeAction", keymaps.code_action)
	Utils.lsp_keymap_set_by_method("textDocument/reference", keymaps.finder)
	Utils.lsp_keymap_set_by_method("textDocument/rename", keymaps.rename)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostics)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_jump_prev)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_jump_next)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_prev_warn)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_next_warn)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_prev_error)
	Utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_next_error)
end

return M
