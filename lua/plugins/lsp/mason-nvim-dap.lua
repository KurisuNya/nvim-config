---@diagnostic disable: missing-fields
local status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not status then
	return
end
mason_nvim_dap.setup({
	automatic_installation = true,
	ensure_installed = {
		"debugpy",
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
