local img_paste_dir = "./assets/img"
local M = {
	"dfendr/clipboard-image.nvim",
	opts = { markdown = {
		img_dir = img_paste_dir,
		img_dir_txt = img_paste_dir,
	} },
	ft = "markdown",
}

M.keys = function()
	vim.keymap.set("n", "<leader>mP", "<CMD>PasteImg<CR>", {
		desc = "Markdown Image Paste (To '" .. img_paste_dir .. "')",
		noremap = true,
		silent = true,
	})
end

return M
