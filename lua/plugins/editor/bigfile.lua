---@diagnostic disable: assign-type-mismatch
local M = {}
M.config = function()
	local opts = {
		filesize = 1,
		pattern = { "*" },
		features = {
			"lsp",
			"treesitter",
			"illuminate",
			"indent_blankline",
			"syntax",
			"filetype",
			"vimopts",
		},
	}
	if KurisuNya.utils.plugin_exist("nvim-cmp") then
		local cmp = {
			name = "nvim-cmp",
			opts = { defer = true },
			disable = function()
				require("cmp").setup.buffer({ enabled = false })
			end,
		}
		table.insert(opts.features, cmp)
	end
	require("bigfile").setup(opts)
end
return M
