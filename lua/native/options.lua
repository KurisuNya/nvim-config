--------------------
-- visual options --
--------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "88,100"
vim.opt.fillchars = Icons.fillchars
vim.diagnostic.config({
	virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
	signs = {
		text = {
			[1] = Icons.diagnostics.Error,
			[2] = Icons.diagnostics.Warning,
			[3] = Icons.diagnostics.Info,
			[4] = Icons.diagnostics.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

--------------------
-- editor options --
--------------------
-- scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- swap
vim.opt.swapfile = false
-- split
vim.opt.splitbelow = true
vim.opt.splitright = true
-- undo
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
-- diff
vim.opt.diffopt = { "internal", "filler", "closeoff", "linematch:60", "foldcolumn:0" }
-- clipboard
vim.opt.clipboard:append("unnamedplus")
if os.getenv("SSH_TTY") or os.getenv("USER") == "root" then
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
end
-- fold
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.highlighted_foldtext()"
_G.highlighted_foldtext = function()
	local line = vim.fn.getline(vim.v.foldstart)
	local len = vim.v.foldend - vim.v.foldstart
	local suffix = "  󰁂 " .. len .. (len > 1 and " lines" or " line") .. " folded "
	local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
	local parser = vim.treesitter.get_parser(0, lang, { error = false })
	if not parser then
		return line .. suffix
	end
	local query = vim.treesitter.query.get(parser:lang(), "highlights")
	if not query then
		return line .. suffix
	end

	local line_pos = 0
	local prev_range = nil
	local result = {}

	local pos = vim.v.foldstart
	local tree = parser:parse({ pos - 1, pos })[1]
	for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
		local start_row, start_col, end_row, end_col = node:range()
		if start_row ~= pos - 1 or end_row ~= pos - 1 then
			goto continue
		end
		local range = { start_col, end_col }
		if start_col > line_pos then
			table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
		end
		local name = query.captures[id]
		local text = vim.treesitter.get_node_text(node, 0)
		if prev_range == nil then
			table.insert(result, { text, "@" .. name })
		elseif range[1] == prev_range[1] and range[2] == prev_range[2] then
			result[#result] = { text, "@" .. name }
		elseif start_col < line_pos then
			goto continue
		else
			table.insert(result, { text, "@" .. name })
		end
		prev_range = range
		line_pos = end_col
		::continue::
	end
	return vim.list_extend(result, { { suffix, "Folded" } })
end
