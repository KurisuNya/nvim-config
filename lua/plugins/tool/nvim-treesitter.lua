---@diagnostic disable: missing-fields
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	--默认安装
	ensure_installed = {
		"bash",
		"c",
		"comment",
		"cpp",
		"gitcommit",
		"gitignore",
		"java",
		"lua",
		"markdown",
		"markdown_inline",
		"php",
		"python",
		"regex",
		"rust",
		"scss",
		"vim",
		"yuck",
	},
	-- 启用代码高亮模块
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = { "python" },
	},
	autotag = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
})
-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
vim.opt.foldlevel = 99
