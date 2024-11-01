---@diagnostic disable: undefined-doc-name, assign-type-mismatch
local M = {}
M.config = function()
	local opts = {
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				runner = "pytest",
				python = function()
					if KurisuNya.utils.plugin_exist("venv-selector.nvim") then
						return require("venv-selector").get_active_path()
					end
				end,
			}),
			require("neotest-java")({
				ignore_wrapper = true, -- whether to ignore maven/gradle wrapper
			}),
		},
		summary = {
			open = "botright vsplit | vertical resize 40",
		},
	}
	require("neotest").setup(opts)
end
return M
