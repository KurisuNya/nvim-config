local M = {}
M.keys = {
	{
		"L",
		"<Cmd>GitMessenger<CR>",
		desc = "Git Info",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
M.on_attach = function(buffer)
	vim.api.nvim_buf_set_keymap(buffer, "n", "<esc>", "<Cmd>GitMessengerClose<CR>", {
		noremap = true,
		silent = true,
		desc = "Git Info Quit",
	})
end
return M
