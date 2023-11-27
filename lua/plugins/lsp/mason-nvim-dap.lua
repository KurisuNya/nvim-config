---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	local mason_nvim_dap = require("mason-nvim-dap")
	mason_nvim_dap.setup({
		automatic_installation = true,
		ensure_installed = {
			"bash-debug-adapter",
			"codelldb",
			"debugpy",
			"java-debug-adapter",
			"java-test",
		},
		handlers = {
			function(config)
				mason_nvim_dap.default_setup(config)
			end,
			python = function(config)
				config.adapters = {
					type = "executable",
					command = "/usr/bin/python3",
					args = {
						"-m",
						"debugpy.adapter",
					},
				}
				mason_nvim_dap.default_setup(config)
			end,
		},
	})
end
return M
