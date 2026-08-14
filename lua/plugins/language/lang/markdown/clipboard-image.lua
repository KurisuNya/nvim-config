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
  Utils.filetype_keymap_set("markdown", {
    mode = "n",
    key = "<leader>mP",
    cmd = "<CMD>PasteImg<CR>",
    opts = {
      desc = "Markdown Image Paste (To '" .. img_paste_dir .. "')",
      silent = true,
    },
  })
end

return M
