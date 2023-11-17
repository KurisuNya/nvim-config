-----------------
--  lspconfig  --
-----------------
local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>s", "<Cmd>Lspsaga outline<CR>", opts)
keymap.set("n", "<leader>t", "<Cmd>Lspsaga term_toggle<CR>", opts)
keymap.set({ "n", "i", "s" }, "<c-d>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-d>"
	end
end, { silent = true, expr = true })
keymap.set({ "n", "i", "s" }, "<c-u>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-u>"
	end
end, { silent = true, expr = true })

local M = {}
M.lsp_on_attach = function()
	keymap.set("n", "gr", "<Cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>Lspsaga goto_definition<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename mode=n<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "H", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
	keymap.set("n", "gH", vim.lsp.buf.signature_help, opts) -- show documentation for what is under cursor
end
M.jdtls_debug_on_attach = function()
	keymap.set("n", "<leader>dj", require("jdtls.dap").test_class, opts)
	-- keymap.set("n", "<leader>dj", require("jdtls.dap").test_nearest_method, opts)
	keymap.set("n", "<leader>dJ", require("jdtls.dap").pick_test, opts)
end
M.outline_keymap = {
	toggle_or_jump = "<Tab>",
	quit = { "<Esc>", "q" },
	jump = "<CR>",
}
M.finder_keymap = {
	toggle_or_open = "<CR>",
	quit = { "<Esc>", "q" },
}
return M
