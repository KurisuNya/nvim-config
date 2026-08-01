local M = {
	"iamcco/markdown-preview.nvim",
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_auto_close = 0
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = "markdown",
}

M.keys = function()
	Utils.filetype_keymap_set("markdown", {
		mode = "n",
		key = "<leader>mp",
		cmd = "<CMD>MarkdownPreviewToggle<CR>",
		opts = {
			desc = "Markdown Preview Toggle",
			silent = true,
		},
	})
end
return M
