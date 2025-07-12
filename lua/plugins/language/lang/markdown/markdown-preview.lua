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
	vim.keymap.set("n", "<leader>mp", "<CMD>MarkdownPreviewToggle<CR>", {
		desc = "Markdown Preview Toggle",
		noremap = true,
		silent = true,
	})
end
return M
