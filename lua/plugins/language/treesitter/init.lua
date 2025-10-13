---@diagnostic disable: missing-fields
PluginVars.insert(PluginVars.mason_ensure_installed, "tree-sitter-cli")
PluginVars.treesitter_ensure_installed = {
	"bash",
	"regex",
	"markdown",
	"markdown_inline",
	"gitcommit",
	"gitignore",
	"gitattributes",
}

local M = {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	build = ":TSUpdate",
	event = "VeryLazy",
	lazy = vim.fn.argc(-1) == 0,
}

M.dependencies = {
	{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
}

M.opts = function()
	return {
		ensure_installed = Utils.tbl_filter_same(PluginVars.treesitter_ensure_installed),
		highlight = { enable = true },
		indent = { enable = true },
		fold = { enable = true },
	}
end

M.config = function(_, opts)
	local TS = require("nvim-treesitter")
	PluginVars.treesitter = require("plugins.language.treesitter.custom")

	PluginVars.treesitter.get_installed(true)
	local install = vim.tbl_filter(function(lang)
		return not PluginVars.treesitter.have(lang)
	end, opts.ensure_installed or {})
	if #install > 0 then
		TS.install(install, { summary = true }):await(function()
			PluginVars.treesitter.get_installed(true)
		end)
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = Utils.create_augroup("treesitter"),
		callback = function(ev)
			local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
			if not PluginVars.treesitter.have(ft) then
				return
			end

			---@param feat string
			---@param query string
			local function enabled(feat, query)
				local f = opts[feat] or {}
				return f.enable ~= false
					and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
					and PluginVars.treesitter.have(ft, query)
			end

			if enabled("highlight", "highlights") then
				pcall(vim.treesitter.start)
			end
			if enabled("indent", "indents") then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
			if enabled("fold", "folds") then
				vim.opt.foldmethod = "expr"
				vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end
		end,
	})
end

return M
