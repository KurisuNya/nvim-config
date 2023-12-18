local M = {}
local icons = require("plugins.ui.icons")
M.config = function()
	local map_list = require("core.keymaps.lspconfig")
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
		code_action = {
			keys = map_list.lspsaga_code_action_keymap,
		},
		finder = {
			keys = map_list.lspsaga_finder_keymap,
		},
		outline = {
			layout = "float",
			keys = map_list.lspsaga_outline_keymap,
		},
	})
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lspsaga_attach", {}),
		callback = function(args)
			local bufnr = args.buf ---@type number
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			require("core.keymaps.lspconfig").lspsaga_on_attach(client, bufnr)
		end,
	})
end
return M
