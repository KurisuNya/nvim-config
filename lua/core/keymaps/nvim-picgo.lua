local M = {}
M.keys = {
	{
		"<leader>pc",
		":PicgoUpload ~/Pictures/",
		mode = "n",
		noremap = true,
		silent = false,
		desc = "Picture Upload",
	},
}
return M
