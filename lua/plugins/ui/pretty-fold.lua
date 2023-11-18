---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	require("pretty-fold").setup({
		keep_indentation = false,
		fill_char = " ",
		sections = {
			left = {
				"",
				function()
					return string.rep(" ", vim.v.foldlevel)
				end,
				" ",
				"number_of_folded_lines",
				":",
				"content",
			},
		},
	})
end
return M
