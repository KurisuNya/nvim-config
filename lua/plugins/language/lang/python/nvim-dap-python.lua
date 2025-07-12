PluginVars.insert(PluginVars.mason_ensure_installed, "debugpy")

local M = {
	"mfussenegger/nvim-dap-python",
	dependencies = {
		"mfussenegger/nvim-dap",
		"williamboman/mason.nvim",
	},
	ft = "python",
}

M.init = function()
	PluginVars.dap_configurations["python"] = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			justMyCode = true,
		},
		{
			type = "python",
			request = "launch",
			name = "Not only my code",
			program = "${file}",
			justMyCode = false,
		},
	}
end

M.config = function()
	local mason_registry = require("mason-registry")
	if not mason_registry.is_installed("debugpy") then
		vim.notify("debugpy is not installed. Please run :MasonInstall debugpy", vim.log.levels.WARN)
	end
	local path = vim.fn.expand("$MASON/packages/debugpy")
	if Utils.is_windows() then
		require("dap-python").setup(path .. "/venv/Scripts/python.exe")
	else
		require("dap-python").setup(path .. "/venv/bin/python")
	end
end

return M
