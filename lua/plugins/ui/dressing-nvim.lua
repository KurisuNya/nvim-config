local M = {}

M.init = function()
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.select = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.input = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.input(...)
	end
end
M.config = function()
	local opts = {
		input = { insert_only = false },
	}
	if KurisuNya.utils.plugin_exist("telescope.nvim") then
		opts.select = { backend = { "telescope" } }
	elseif KurisuNya.utils.plugin_exist("nui.nvim") then
		opts.select = { backend = { "nui" } }
	else
		opts.select = { backend = { "builtin" } }
	end
	require("dressing").setup(opts)
end
return M
