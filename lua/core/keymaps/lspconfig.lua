local M = {}
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

M.lspsaga_outline_keymap = {
	toggle_or_jump = "<Tab>",
	quit = { "<Esc>", "q" },
	jump = "<CR>",
}
M.lspsaga_finder_keymap = {
	toggle_or_open = "<CR>",
	quit = { "<Esc>", "q" },
}
M.lspsaga_code_action_keymap = {
	quit = { "<Esc>", "q" },
	exec = "<CR>",
}

-- on attach
local function lsp_keymap_set(mode, key, cmd, opts)
	vim.keymap.set(
		mode,
		key,
		cmd,
		vim.tbl_extend("force", {
			noremap = true,
			silent = true,
		}, opts)
	)
end

M.lspconfig_on_attach = function(client, bufnr)
	if client.name == "copilot" or client.name == "null-ls" then
		return
	end
	if client.name == "pyright" then
		lsp_keymap_set("n", "<leader>co", "<Cmd>PyrightOrganizeImports<CR>", {
			buffer = bufnr,
			desc = "Code Organize Imports",
		})
		if require("lazy.core.config").spec.plugins["venv-selector.nvim"] ~= nil then
			lsp_keymap_set("n", "<leader>cv", "<Cmd>VenvSelect<CR>", {
				buffer = bufnr,
				desc = "Change Venv",
			})
		end
	end
	lsp_keymap_set("n", "H", vim.lsp.buf.hover, {
		buffer = bufnr,
		desc = "Lsp Hover Doc",
	})
	lsp_keymap_set("n", "gH", vim.lsp.buf.signature_help, {
		buffer = bufnr,
		desc = "Lsp Signature Help",
	})
	lsp_keymap_set("i", "<C-h>", vim.lsp.buf.signature_help, {
		buffer = bufnr,
		desc = "Lsp Signature Help",
	})
end

M.gtd_on_attach = function(client, bufnr)
	if client.name == "copilot" or client.name == "null-ls" then
		return
	end
	lsp_keymap_set("n", "gd", function()
		require("gtd").exec({ command = "edit" })
	end, {
		buffer = bufnr,
		desc = "Lsp Goto Definition",
	})
end

M.nvim_navbuddy_on_attach = function(client, bufnr)
	if client.name == "copilot" or client.name == "null-ls" then
		return
	end
	lsp_keymap_set("n", "<leader>s", "<Cmd>Navbuddy<CR>", {
		buffer = bufnr,
		desc = "Lsp Symbols Explorer",
	})
end

M.lspsaga_on_attach = function(client, bufnr)
	if client.name == "copilot" then
		return
	end
	if client.name ~= "null-ls" then
		lsp_keymap_set("n", "<leader>S", "<Cmd>Lspsaga outline<CR>", {
			buffer = bufnr,
			desc = "Lsp Symbols Float",
		})
		lsp_keymap_set("n", "gr", "<Cmd>Lspsaga finder<CR>", {
			buffer = bufnr,
			desc = "Lsp Find Reference",
		})
		lsp_keymap_set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", {
			buffer = bufnr,
			desc = "Lsp Rename",
		})
	end
	lsp_keymap_set("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", {
		buffer = bufnr,
		desc = "Lsp Code Action",
	})
	lsp_keymap_set("n", "<leader>D", "<Cmd>Lspsaga show_line_diagnostics<CR>", {
		buffer = bufnr,
		desc = "Lsp Line Diagnostic",
	})
	lsp_keymap_set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {
		buffer = bufnr,
		desc = "Previous Lsp Diagnostic",
	})
	lsp_keymap_set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {
		buffer = bufnr,
		desc = "Next Lsp Diagnostic",
	})
end

M.jdtls_debug_on_attach = function(client, bufnr)
	if client.name == "copilot" or client.name == "null-ls" then
		return
	end
	lsp_keymap_set("n", "<leader>dj", require("jdtls.dap").test_class, {
		buffer = bufnr,
		desc = "Dap Java Test Class",
	})
	lsp_keymap_set("n", "<leader>dJ", require("jdtls.dap").pick_test, {
		buffer = bufnr,
		desc = "Dap Java Pick Test",
	})
end

return M
