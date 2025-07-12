local M = {
	"nvim-neotest/neotest",
	event = "VeryLazy",
}

M.dependencies = {
	"nvim-neotest/nvim-nio",
	"nvim-lua/plenary.nvim",
}

M.init = function()
	PluginVars.insert(PluginVars.q_close_filetypes, "neotest-summary")
	PluginVars.insert(PluginVars.projections_close_filetypes, "neotest-summary")
end

M.keys = {
	{
		"<leader>tt",
		function()
			require("neotest").run.run(vim.uv.cwd())
			require("neotest").summary.open()
		end,
		desc = "Test All Test Files",
	},
	{
		"<leader>ts",
		function()
			require("neotest").run.stop()
			require("neotest").summary.close()
		end,
		desc = "Test Stop",
	},
	{
		"<leader>s",
		function()
			require("neotest").summary.toggle()
		end,
		desc = "Toggle Test Summary",
	},
}

PluginVars.neotest_adapters = {}

M.opts = function()
	local opts = {
		adapters = {},
		summary = { open = "botright vsplit | vertical resize 40" },
	}
	for _, adapter in ipairs(PluginVars.neotest_adapters) do
		if type(adapter) == "function" then
			table.insert(opts.adapters, adapter())
		else
			table.insert(opts.adapters, adapter)
		end
	end
	return opts
end

return M
