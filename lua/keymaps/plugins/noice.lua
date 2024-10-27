local M = {}
M.keys = function()
	if KurisuNya.utils.plugin_exist("nvim-lspcofig") then
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
	end
	if KurisuNya.utils.plugin_exist("telescope.nvim") then
		vim.keymap.set("n", "<leader>fm", "<Cmd>Noice telescope<CR>", {
			silent = true,
			noremap = true,
			desc = "Find Message",
		})
	end
end
M.open_link_key = "H"
return M
