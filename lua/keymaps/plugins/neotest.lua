---@diagnostic disable: missing-fields
local M = {}

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
		"<leader>S",
		function()
			require("neotest").summary.toggle()
		end,
		desc = "Toggle Test Summary",
	},
}
return M
