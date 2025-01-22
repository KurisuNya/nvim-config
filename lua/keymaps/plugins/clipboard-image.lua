local M = {}
M.keys = {
	{
		"<leader>pp",
		"<Cmd>PasteImg<CR>",
		mode = "n",
		noremap = true,
		silent = true,
		desc = "Picture Paste (To ./assets/img/)",
	},
}
return M
