KurisuNya.config = {}
KurisuNya.config.enable_plugin = true
KurisuNya.config.q_close_filetypes = {
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
KurisuNya.config.wrap_spell_filetypes = { "gitcommit", "markdown" }

if not KurisuNya.config.enable_plugin then
	return
end
KurisuNya.config.use_copilot = true
KurisuNya.config.lualine_hidden_lsp = { "copilot", "null-ls" }
KurisuNya.config.close_before_session_filetypes = { "qf", "help" }
KurisuNya.config.workspaces = {
	{ "~/Documents/Projects/Develop", {} },
	{ "~/Documents/Projects/Reference", {} },
	{ "~/Documents/Projects/Fork", {} },
	{ "~/Documents/Projects/Test", {} },
	{ "~/Documents/Projects/HomeWork", {} },
	"~/.config",
	"~/.local/share/nvim/lazy",
}

-- stylua: ignore start
KurisuNya.config.treesitter_ensure_installed = {
	"bash", "c", "comment", "cpp", "css",
	"diff", "gitcommit", "gitignore", "html", "java",
	"javascript", "jsdoc", "json", "jsonc", "lua",
	"luadoc", "luap", "markdown", "markdown_inline", "matlab",
	"ninja", "php", "python", "query", "regex",
	"rst", "rust", "scss", "toml", "tsx",
	"typescript", "vim", "vimdoc", "yaml", "yuck",
}
-- stylua: ignore end
KurisuNya.config.lsp_ensure_installed = {
	"bash-language-server",
	"clangd",
	"jdtls",
	"json-lsp",
	"lemminx",
	"lua-language-server",
	"pyright",
	"taplo",
}
KurisuNya.config.dap_ensure_installed = {
	"bash-debug-adapter",
	"codelldb",
	"debugpy",
	"java-debug-adapter",
	"java-test",
}
KurisuNya.config.linter_ensure_installed = { "shellcheck" }
KurisuNya.config.formatter_ensure_installed = {
	"black",
	"clang-format",
	"google-java-format",
	"prettier",
	"shfmt",
	"stylua",
}

if vim.loop.os_uname().sysname == "Windows_NT" then
	table.insert(KurisuNya.config.linter_ensure_installed, "codespell")
else
	table.insert(KurisuNya.config.linter_ensure_installed, "cspell")
end
