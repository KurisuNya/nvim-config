-----------------
--  lspconfig  --
-----------------
local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>s", "<cmd>Lspsaga outline<CR>", opts)
keymap.set("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opts)

local M = {}
local keymap = vim.keymap -- for conciseness
M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true }
	keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>Lspsaga goto_definition<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename mode=n<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "H", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
end
return M
