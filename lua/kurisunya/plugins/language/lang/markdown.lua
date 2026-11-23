PicoPack.opts_extend("nvim-treesitter", {
  ensure_installed = { "markdown", "markdown_inline" },
}, { extend = "ensure_installed" })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = Utils.autocmd.new_group("markdown_win_options"),
  pattern = "markdown",
  callback = function() vim.wo[0][0].wrap = true end,
})

local img_paste_dir = "./assets/img"

---@type PicoPack.Spec
local image_spec = {
  PicoPack.url.gh("dfendr/clipboard-image.nvim"),
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
    group = Utils.autocmd.new_group("markdown_image"),
    pattern = "markdown",
    callback = function(ev) Utils.keymap.set_maps(image_maps, { buffer = ev.buf }) end,
  })
end

PicoPack.register(image_spec)

---@type PicoPack.Spec
local preview_spec = {
  PicoPack.url.gh("toppair/peek.nvim"),
  build = "deno task --quiet build:fast",
  filetype = "markdown",
}

local preview_maps = {
  {
    "n",
    "<leader>mp",
    function()
      local peek = require("peek")
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end,
    { desc = "Markdown Preview" },
  },
}

preview_spec.config = function()
  require("peek").setup({ app = "browser", theme = "light" })
  vim.api.nvim_create_autocmd("FileType", {
    group = Utils.autocmd.new_group("markdown_preview"),
    pattern = "markdown",
    callback = function(ev) Utils.keymap.set_maps(preview_maps, { buffer = ev.buf }) end,
  })
end

PicoPack.register(preview_spec)

---@type PicoPack.Spec
local table_spec = {
  PicoPack.url.gh("Kicamon/markdown-table-mode.nvim"),
  filetype = "markdown",
  config = function() require("markdown-table-mode").setup() end,
}

PicoPack.register(table_spec)
