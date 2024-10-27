local M = {}
M.keys = {
	{
		"<leader>mp",
		"<Cmd>MarkdownPreviewToggle<CR>",
		desc = "Markdown Preview Toggle",
		mode = "n",
		noremap = true,
		silent = true,
	},
}
return M
