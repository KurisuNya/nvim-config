PluginVars.insert(PluginVars.neotest_adapters, function()
	local opts = {
		dap = { justMyCode = false },
		runner = "pytest",
		args = { "--cov", "src", "--cov-report=html" },
	}
	if Utils.plugin_exists("venv-selector.nvim") then
		opts.python = function()
			return require("venv-selector").python()
		end
	end
	return require("neotest-python")(opts)
end)

return { "nvim-neotest/neotest-python" }
