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
	PluginVars.insert(PluginVars.q_close_filetypes, "neotest-output")
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

local mappings = {
	attach = "a",
	clear_marked = "M",
	clear_target = "T",
	debug = "d",
	debug_marked = "D",
	expand = { "<CR>", "<2-LeftMouse>" },
	expand_all = "e",
	help = "?",
	jumpto = "i",
	mark = "m",
	next_failed = "]",
	output = "o",
	prev_failed = "[",
	run = "r",
	run_marked = "R",
	short = "O",
	stop = "u",
	target = "t",
	watch = "w",
}

PluginVars.neotest_adapters = {}

M.opts = function()
	local opts = {
		adapters = {},
		floating = { border = Config.border_style },
		summary = {
			mappings = mappings,
			open = "botright vsplit | vertical resize 40",
		},
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
