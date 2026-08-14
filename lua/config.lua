local M = {}
M.enable_plugins = true
M.enable_ai = true
M.ai_cli = "opencode"
M.format_on_save = true

M.default_colorscheme = "tokyonight-storm"

-- "bold": Bold line box.
-- "double": Double-line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "single": Single-line box.
-- "solid": Adds padding by a single whitespace cell.
M.border_style = "rounded"
M.border_style_fallback = "rounded"
M.cmp_border_style = "rounded"

M.workspaces = {
}

M.dashboard_header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣶⣖⣀⢲⣶⣶⢂⠢⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣶⣿⣿⡇⠀⢻⣿⣿⠁⢿⣿⡇⠿⢀⣿⣿⡆⣼⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⡟
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡐⣿⣿⣦⢰⣿⡿⠃⠋⣉⣅⣤⣤⣤⣤⣤⣤⣉⠉⠛⠴⣿⣿⢁⡾⢠⣿⣤⡀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⠁
⠀⠀⠀⠀⠀⠀⠀⣴⣿⣌⠻⠆⣿⠛⣉⡴⠚⠉⠉⠀⠀⠀⠹⣿⣿⣿⣿⠏⠀⠉⠛⢶⣤⠀⠶⣿⣿⣿⣿⣶⡀⢻⣿⣿⣿⣿⣿⣿⡿⠀
⠀⠀⠀⠀⠀⣠⢧⠻⠿⣿⠟⢁⣴⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣷⣄⠛⣿⣿⠋⣤⣿⣿⣿⣿⣿⣿⣿⠁⠀
⠀⠀⠀⠀⣾⣿⣿⣤⡽⢁⡶⢿⣿⣿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀
⠀⠀⠀⣾⣄⠀⣭⠏⣠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣄⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢀⣶⣿⣿⣿⣿⠟⠁⡀⢻⠏⠀⠀⠀
⠀⠀⣼⣶⣄⣒⡏⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⠟⠁⣴⣿⣿⠀⠀⠀⠀⠀
⠀⠀⣛⠛⠛⢿⢀⣯⣤⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⣠⣾⣿⣿⣿⣿⠟⠁⡄⢻⣿⣿⣿⣧⠀⠀⠀⠀
⠀⢸⣭⣀⣛⡏⢸⣿⣿⣿⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⣤⣿⣿⣿⣿⣿⠛⠀⠀⣀⣽⢸⣿⣿⣿⣿⠀⠀⠀⠀
⠀⢸⣿⡿⠿⡇⢿⣿⣿⡇⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⢁⣴⣿⣿⣿⣿⡿⠉⠀⠀⠀⣿⣿⣿⢨⣿⣿⣿⣿⠀⠀⠀⠀
⠀⢰⣭⣴⣧⣧⢸⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⠟⠁⣤⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⢠⣿⣿⣿⢸⣿⣿⣿⣿⠀⠀⠀⠀
⠀⠀⣿⠛⢛⠛⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⠟⠉⣤⣾⣿⣿⣿⣿⠛⢉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠁⣿⣿⣿⣿⡏⠀⠀⠀⠀
⠀⠀⢠⠛⠛⣡⣷⠈⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣤⣾⣿⣿⣿⣿⠛⢉⡤⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠋⣴⣿⣿⣿⣿⠀⠀⠀⠀⠀
⠀⠀⠀⢻⣿⣿⣿⣷⠈⣿⣿⣿⣦⠀⠀⢀⣤⣾⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⣠⠋⣴⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠻⣿⣿⣿⣿⣤⠙⠉⣠⣴⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⠟⣠⣾⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀
⠀⠀⣾⠀⣤⠈⢿⣿⣿⣿⣿⣤⠙⠛⠋⠉⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡿⠋⣠⣾⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀
⢀⣿⣀⣈⣤⣴⣤⠉⢿⣿⣿⣿⣿⣷⣤⣉⠓⠦⣤⣠⣿⣿⣿⣿⣿⠀⠀⣀⣤⠤⠒⢉⣤⣶⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠿⠛⠛⠉⠁⠀⠀⠀⠀⠈⠛⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣥⣅⣥⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]

M.dashboard_buttons = {
  { key = "p", name = "  Open Project", cmd = "<CMD>Telescope projections<CR>" },
  { key = "s", name = "  Last Session", cmd = "<CMD>ProjectionsLastSession<CR>" },
  { key = "l", name = "󰒲  Lazy Manager", cmd = "<CMD>Lazy<CR>" },
  { key = "m", name = "  Mason Manager", cmd = "<CMD>Mason<CR>" },
  { key = "q", name = "  Quit Neovim", cmd = "<CMD>qa<CR>" },
}
M.dashboard_footer_name = "KurisuNya Neovim 󰒲"

M.lualine_section_separators = { left = "", right = "" }
M.lualine_component_separators = { left = "", right = "" }
return M
