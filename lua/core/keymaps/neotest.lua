---@diagnostic disable: missing-fields
local M = {}

_G.neo_test_summary = false
local function open_summary()
	require("neotest").summary.open()
	_G.neo_test_summary = true
end
local function close_summary()
	require("neotest").summary.close()
	_G.neo_test_summary = false
end
local function toggle_summary()
	require("neotest").summary.toggle()
	_G.neo_test_summary = not _G.neo_test_summary
end

M.keys = {
	{
		"<leader>tt",
		function()
			require("neotest").run.run(vim.uv.cwd() .. "/tests")
			open_summary()
		end,
		desc = "Test All Test Files",
	},
	{
		"<leader>ts",
		function()
			require("neotest").run.stop()
			close_summary()
		end,
		desc = "Test Stop",
	},
	{
		"<leader>s",
		toggle_summary,
		desc = "Toggle Test Summary",
	},
}
return M
