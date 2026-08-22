Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "markdown", "markdown_inline" },
}, { extend = "ensure_installed" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function() vim.wo[0][0].wrap = true end,
})

local img_paste_dir = "./assets/img"

---@type Manager.Spec
local image_spec = {
  Manager.url.gh("dfendr/clipboard-image.nvim"),
  filetype = "markdown",
}

local image_maps = {
  {
    "n",
    "<leader>mP",
    "<CMD>PasteImg<CR>",
    { desc = "Markdown Image Paste (To '" .. img_paste_dir .. "')" },
  },
}

image_spec.opts = {
  markdown = {
    img_dir = img_paste_dir,
    img_dir_txt = img_paste_dir,
  },
}

image_spec.config = function(opts)
  require("clipboard-image").setup(opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev) Utils.keymap.set_maps(image_maps, { buffer = ev.buf }) end,
  })
end

Manager.add(image_spec)

---@type Manager.Spec
local preview_spec = {
  Manager.url.gh("iamcco/markdown-preview.nvim"),
  build = "cd app && yarn install",
  filetype = "markdown",
}

local preview_maps = {
  {
    "n",
    "<leader>mp",
    "<CMD>MarkdownPreviewToggle<CR>",
    { desc = "Markdown Preview Toggle" },
  },
}

preview_spec.init = function()
  vim.g.mkdp_auto_close = 0
  vim.g.mkdp_filetypes = { "markdown" }
end

preview_spec.config = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev) Utils.keymap.set_maps(preview_maps, { buffer = ev.buf }) end,
  })
end

Manager.add(preview_spec)
