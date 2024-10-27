local M = {}
local icons = require("plugins.ui.icons")
M.config = function()
	local map_list = require("keymaps.plugins.lspsaga")
	require("lspsaga").setup({
		symbol_in_winbar = { enable = false },
		lightbulb = { enable = false },
		ui = {
			expand = icons.ui.ArrowClose,
			collapse = icons.ui.ArrowOpen,
			lines = { "└", "├", "│", "─", "┌" },
		},
		rename = { in_select = false, auto_save = true },
		implement = { enable = true, sign = false },
		code_action = { keys = map_list.code_action_keymap },
		finder = { keys = map_list.finder_keymap },
		outline = { layout = "float", keys = map_list.outline_keymap },
	})

	local keymaps = map_list.keymaps
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/codeAction", keymaps.code_action)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/reference", keymaps.finder)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/rename", keymaps.rename)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostics)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_jump_prev)
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/diagnostics", keymaps.diagnostic_jump_next)
end
return M
