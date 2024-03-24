local M = {}
M.config = function()
	local path = require("mason-registry").get_package("debugpy"):get_install_path()

	if vim.loop.os_uname().sysname == "Windows_NT" then
		require("dap-python").setup(path .. "/Scripts/python")
	else
		require("dap-python").setup(path .. "/bin/python")
	end
	table.insert(require("dap").configurations.python, {
		type = "python",
		request = "launch",
		name = "Not only my code",
		program = "${file}",
		justMyCode = false,
	})
end
return M
