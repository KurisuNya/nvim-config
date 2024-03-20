local M = {}
M.config = function()
	local path = require("mason-registry").get_package("debugpy"):get_install_path()
	require("dap-python").setup(path .. "/venv/bin/python")
	table.insert(require("dap").configurations.python, {
		type = "python",
		request = "launch",
		name = "Not only my code",
		program = "${file}",
		justMyCode = false,
	})
end
return M
