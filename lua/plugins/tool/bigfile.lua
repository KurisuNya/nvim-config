---@diagnostic disable: assign-type-mismatch
local M = {}
M.config = function()
	local cmp = {
		name = "nvim-cmp",
		opts = { defer = true },
		disable = function()
			require("cmp").setup.buffer({ enabled = false })
		end,
	}

	require("bigfile").setup({
		filesize = 1,
		pattern = { "*" },
		features = {
			"illuminate",
			"treesitter",
			"syntax",
			"vimopts",
			cmp,
		},
	})
end
return M
