local M = {}
M.config = function()
	local mason_registry = require("mason-registry")
	if not mason_registry.is_installed("debugpy") then
		return
	end
	local path = mason_registry.get_package("debugpy"):get_install_path()
	if KurisuNya.utils.is_windows() then
		require("dap-python").setup(path .. "/venv/Scripts/python.exe")
	else
		require("dap-python").setup(path .. "/venv/bin/python")
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
