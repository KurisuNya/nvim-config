local M = {}

M.config = function()
	local opts = {
		auto_refresh = true,
		poetry_path = "~/.venv",
		name = {
			"venv",
			".venv",
			"env",
			".env",
		},
	}
	if require("lazy.core.config").spec.plugins["nvim-dap-python"] ~= nil then
		opts.dap_enabled = true
	end
	require("venv-selector").setup(opts)

	vim.api.nvim_create_autocmd("BufRead", {
		desc = "Auto select virtualenv Nvim open",
		pattern = "*",
		callback = function()
			local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
			if venv ~= "" then
				require("venv-selector").retrieve_from_cache()
			end
		end,
		once = true,
	})
end

return M
