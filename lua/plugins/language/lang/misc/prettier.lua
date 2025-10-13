PluginVars.insert(PluginVars.mason_ensure_installed, "prettierd")

local filetypes = { "css", "scss", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx" }
local cfg_path = vim.fn.stdpath("config") .. "/lua/plugins/language/lang/misc/prettier.json"
local cfg = { env = { PRETTIERD_DEFAULT_CONFIG = cfg_path } }
PluginVars.insert(PluginVars.conform_formatters, { name = "prettierd", filetypes = filetypes, config = cfg })

return {}
