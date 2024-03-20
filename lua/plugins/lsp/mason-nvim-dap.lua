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
	})
end
return M
