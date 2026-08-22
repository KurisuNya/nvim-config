_G.Config = {}

Config.use_nerd_font = true
local in_tty = Utils.os.is_linux() and Utils.os.linux.is_in_tty()
Config.use_nerd_font = Config.use_nerd_font and not in_tty

Config.use_plugins = true

Config.use_ai = true
Config.ai_cli = "opencode"

Config.default_colorscheme = "tokyonight-storm"

-- "bold": Bold line box.
-- "double": Double-line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "single": Single-line box.
-- "solid": Adds padding by a single whitespace cell.
Config.border_style = "rounded"
Config.border_style_fallback = "rounded"

Config.workspaces = {
}

Config.dashboard = {
  header = [[
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
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  buttons = {
    { key = "p", name = "  Open Project", cmd = "<CMD>Telescope projections<CR>" },
    { key = "s", name = "  Last Session", cmd = "<CMD>ProjectionsLastSession<CR>" },
    { key = "l", name = "󰒲  Pack Manager", cmd = "<CMD>Pack<CR>" },
    { key = "m", name = "  Mason Manager", cmd = "<CMD>Mason<CR>" },
    { key = "q", name = "  Quit Neovim", cmd = "<CMD>qa<CR>" },
  },
  footer_name = "KurisuNya Neovim 󰒲",
}

Config.statusline = {
  section_separators = { left = "", right = "" },
  component_separators = { left = "", right = "" },
}
