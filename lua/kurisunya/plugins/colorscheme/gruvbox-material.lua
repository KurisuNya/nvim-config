local activate = function(name)
  Manager.load("gruvbox-material")
  local background = name:match("dark") and "dark" or "light"
  local contrast = name:match("soft") and "soft" or name:match("hard") and "hard" or "medium"
  vim.o.background = background
  vim.g.gruvbox_material_background = contrast
  vim.cmd.colorscheme("gruvbox-material")
end

Manager.opts_extend("colorschemes.nvim", {
  specs = {
    {
      colorschemes = {
        "gruvbox-dark-soft",
        "gruvbox-dark-medium",
        "gruvbox-dark-hard",
        "gruvbox-light-soft",
        "gruvbox-light-medium",
        "gruvbox-light-hard",
      },
      activate = activate,
    },
  },
}, { extend = "specs" })

Manager.add({ Manager.url.gh("sainnhe/gruvbox-material") })
