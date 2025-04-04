local M = {}
--------------------------
--                      --
--  non-plugin configs  --
--                      --
--------------------------
-- configs
M.q_close_filetypes = {
	"help",
	"PlenaryTestPopup",
	"lspinfo",
	"man",
	"notify",
	"query",
	"neotest-output",
	"checkhealth",
	"neotest-summary",
	"neotest-output-panel",
}
M.wrap_spell_filetypes = { "gitcommit", "markdown" }
if not KurisuNya.enable_plugin then
	return M
end
----------------------
--                  --
--  plugin configs  --
--                  --
----------------------
-- flags
M.use_copilot = true
-- configs
M.colorscheme = "tokyonight-storm"
M.workspaces = {
	"~/.config",
	"~/.local/share/nvim/lazy",
}
M.lualine_section_separators = { left = "", right = "" }
M.lualine_component_separators = { left = "", right = "" }
M.lualine_hidden_lsp = { "copilot", "null-ls" }
M.close_before_session_filetypes = { "qf", "help", "gitcommit" }
M.toggle_pairs = {
	["true"] = "false",
	["True"] = "False",
	["TRUE"] = "FALSE",
	["yes"] = "no",
	["Yes"] = "No",
	["YES"] = "NO",
	["on"] = "off",
	["On"] = "Off",
	["ON"] = "OFF",
	["left"] = "right",
	["Left"] = "Right",
	["LEFT"] = "RIGHT",
	["up"] = "down",
	["Up"] = "Down",
	["UP"] = "DOWN",
	["enable"] = "disable",
	["Enable"] = "Disable",
	["ENABLE"] = "DISABLE",
	["next"] = "previous",
	["Next"] = "Previous",
	["NEXT"] = "PREVIOUS",
	["above"] = "below",
	["Above"] = "Below",
	["ABOVE"] = "BELOW",
	["!="] = "==",
}
-- stylua: ignore start
M.telescope_livegrep_args = {
	"rg", "--color=never", "--no-heading", "--with-filename",
	"--line-number", "--column", "--smart-case", "--trim", "--hidden",
	"--glob", "!**/.git/*",
	"--glob", "!**/node_modules/*",
}
M.telescope_find_files_args = {
	"fd", "--type", "file",
	"--hidden", "--color", "never",
	"-E", "**/.git/*",
	"-E", "**/node_modules/*",
}
M.treesitter_ensure_installed = {
	"bash", "c", "comment", "cpp", "css",
	"diff", "fish", "gitcommit", "gitignore", "html", "java",
	"javascript", "jsdoc", "json", "jsonc", "lua",
	"luadoc", "luap", "markdown", "markdown_inline", "matlab",
	"ninja", "php", "python", "query", "regex",
	"ron", "rst", "rust", "scss", "toml", "tsx",
	"typescript", "vim", "vimdoc", "yaml", "yuck",
}
-- stylua: ignore end
M.lsp_ensure_installed = {
	"bash-language-server",
	"clangd",
	"jdtls",
	"json-lsp",
	"lemminx",
	"lua-language-server",
	"pyright",
	"taplo",
	"tectonic",
	"texlab",
}
M.dap_ensure_installed = {
	"bash-debug-adapter",
	"codelldb",
	"debugpy",
	"java-debug-adapter",
	"java-test",
}
M.linter_ensure_installed = { "shellcheck" }
M.formatter_ensure_installed = {
	"black",
	"clang-format",
	"google-java-format",
	"prettier",
	"shfmt",
	"stylua",
}
if KurisuNya.utils.is_windows() then
	table.insert(M.linter_ensure_installed, "codespell")
else
	table.insert(M.linter_ensure_installed, "cspell")
end
M.header = {
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣶⣖⣀⢲⣶⣶⢂⠢⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣶⣿⣿⡇⠀⢻⣿⣿⠁⢿⣿⡇⠿⢀⣿⣿⡆⣼⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⡟⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡐⣿⣿⣦⢰⣿⡿⠃⠋⣉⣅⣤⣤⣤⣤⣤⣤⣉⠉⠛⠴⣿⣿⢁⡾⢠⣿⣤⡀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⠁⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣌⠻⠆⣿⠛⣉⡴⠚⠉⠉⠀⠀⠀⠹⣿⣿⣿⣿⠏⠀⠉⠛⢶⣤⠀⠶⣿⣿⣿⣿⣶⡀⢻⣿⣿⣿⣿⣿⣿⡿⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⣠⢧⠻⠿⣿⠟⢁⣴⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣷⣄⠛⣿⣿⠋⣤⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀]],
	[[⠀⠀⠀⠀⠀⣾⣿⣿⣤⡽⢁⡶⢿⣿⣿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⣿⣿⣿⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⠋⠀⠀⠀]],
	[[⠀⠀⠀⠀⣾⣄⠀⣭⠏⣠⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣄⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢀⣶⣿⣿⣿⣿⠟⠁⡀⢻⠏⠀⠀⠀⠀]],
	[[⠀⠀⠀⣼⣶⣄⣒⡏⣰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⠟⠁⣴⣿⣿⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⣛⠛⠛⢿⢀⣯⣤⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⣠⣾⣿⣿⣿⣿⠟⠁⡄⢻⣿⣿⣿⣧⠀⠀⠀⠀⠀]],
	[[⠀⠀⢸⣭⣀⣛⡏⢸⣿⣿⣿⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⣤⣿⣿⣿⣿⣿⠛⠀⠀⣀⣽⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
	[[⠀⠀⢸⣿⡿⠿⡇⢿⣿⣿⡇⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⢁⣴⣿⣿⣿⣿⡿⠉⠀⠀⠀⣿⣿⣿⢨⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
	[[⠀⠀⢰⣭⣴⣧⣧⢸⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⠟⠁⣤⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⢠⣿⣿⣿⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⣿⠛⢛⠛⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⠟⠉⣤⣾⣿⣿⣿⣿⠛⢉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠁⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⢠⠛⠛⣡⣷⠈⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⣤⣾⣿⣿⣿⣿⠛⢉⡤⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠋⣴⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⢻⣿⣿⣿⣷⠈⣿⣿⣿⣦⠀⠀⢀⣤⣾⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⣠⠋⣴⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣤⠙⠉⣠⣴⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⠟⣠⣾⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⣾⠀⣤⠈⢿⣿⣿⣿⣿⣤⠙⠛⠋⠉⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡿⠋⣠⣾⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⢀⣿⣀⣈⣤⣴⣤⠉⢿⣿⣿⣿⣿⣷⣤⣉⠓⠦⣤⣠⣿⣿⣿⣿⣿⠀⠀⣀⣤⠤⠒⢉⣤⣶⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠿⠛⠛⠉⠁⠀⠀⠀⠀⠈⠛⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣤⣥⣅⣥⣤⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
	[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠋⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}
return M
