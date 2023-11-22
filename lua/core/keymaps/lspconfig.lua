local M = {}
M.lspsaga_keys = function()
	vim.keymap.set("n", "<leader>s", "<Cmd>Lspsaga outline<CR>", {
		noremap = true,
		silent = true,
		desc = "Lsp Symbols Float",
	})
end

M.nvim_navbuddy_keys = {
	{
		"<leader>S",
		"<Cmd>Navbuddy<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Lsp Symbols Explorer",
	},
}

M.noice_keys = function()
	vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
		if not require("noice.lsp").scroll(4) then
			return "<c-d>"
		end
	end, { silent = true, expr = true })
	vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
		if not require("noice.lsp").scroll(-4) then
			return "<c-u>"
		end
	end, { silent = true, expr = true })
	vim.keymap.set("n", "<leader>fm", "<Cmd>Noice telescope<CR>", {
		silent = true,
		noremap = true,
		desc = "Find Message",
	})
end

M.lsp_on_attach = function()
	vim.keymap.set("n", "gd", function()
		require("gtd").exec({ command = "edit" })
	end, {
		noremap = true,
		silent = true,
		desc = "Lsp Goto Definition",
	})
	vim.keymap.set("n", "gr", "<Cmd>Lspsaga finder<CR>", {
		noremap = true,
		silent = true,
		desc = "Lsp Find Reference",
	})
	vim.keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", {
		noremap = true,
		silent = true,
		desc = "Lsp Code Action",
	})
	vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename mode=n<CR>", {
		noremap = true,
		silent = true,
		desc = "Lsp Rename",
	})
	vim.keymap.set("n", "<leader>D", "<Cmd>Lspsaga show_line_diagnostics<CR>", {
		noremap = true,
		silent = true,
		desc = "Lsp Line Diagnostic",
	})
	vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {
		noremap = true,
		silent = true,
		desc = "Previous Lsp Diagnostic",
	})
	vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {
		noremap = true,
		silent = true,
		desc = "Next Lsp Diagnostic",
	})
	vim.keymap.set("n", "H", vim.lsp.buf.hover, {
		noremap = true,
		silent = true,
		desc = "Lsp Hover Doc",
	})
	vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, {
		noremap = true,
		silent = true,
		desc = "Lsp Signature Help",
	})
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {
		noremap = true,
		silent = true,
	})
end

M.jdtls_debug_on_attach = function()
	vim.keymap.set("n", "<leader>dj", require("jdtls.dap").test_class, {
		noremap = true,
		silent = true,
		desc = "Dap Java Test Class",
	})
	vim.keymap.set("n", "<leader>dJ", require("jdtls.dap").pick_test, {
		noremap = true,
		silent = true,
		desc = "Dap Java Pick Test",
	})
end

M.lspsaga_outline_keymap = {
	toggle_or_jump = "<Tab>",
	quit = { "<Esc>", "q" },
	jump = "<CR>",
}
M.lspsaga_finder_keymap = {
	toggle_or_open = "<CR>",
	quit = { "<Esc>", "q" },
}
return M
