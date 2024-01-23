---@diagnostic disable: assign-type-mismatch
local M = {}
M.config = function()
	local ftdetect = {
		name = "ftdetect",
		opts = { defer = true },
		disable = function()
			vim.api.nvim_set_option_value("filetype", "big_file_disabled_ft", { scope = "local" })
		end,
	}

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
			"lsp",
			"illuminate",
			"treesitter",
			"syntax",
			"vimopts",
			ftdetect,
			cmp,
		},
	})
end
return M
