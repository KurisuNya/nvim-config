local M = {}

M.config = function()
	local venv_selector = require("venv-selector")

	local function shell_hook(venv_path, venv_python)
		if vim.loop.os_uname().sysname == "Windows_NT" then
			local script_path = venv_path .. "/Scripts/activate"
			if vim.fn.filereadable(script_path) == 1 then
				vim.fn.system("./activate.ps1")
			end
		else
			local script_path = venv_path .. "/bin/activate"
			if vim.fn.filereadable(script_path) == 1 then
				vim.fn.system("source " .. script_path)
			end
		end
	end

	local opts = {
		auto_refresh = true,
		poetry_path = "~/.venv",
		name = {
			"venv",
			".venv",
			"env",
			".env",
		},
		changed_venv_hooks = {
			shell_hook,
			venv_selector.hooks.pyright,
			venv_selector.hooks.pylance,
			venv_selector.hooks.pylsp,
		},
	}
	if require("lazy.core.config").spec.plugins["nvim-dap-python"] ~= nil then
		opts.dap_enabled = true
	end
	venv_selector.setup(opts)

	vim.api.nvim_create_autocmd("User", {
		desc = "Auto select virtualenv Nvim open",
		pattern = { "AlphaClosed", "BufRead" },
		callback = function()
			local root_dir = vim.fn.getcwd() .. ";"

			for _, name in ipairs(opts.name) do
				local venv = vim.fn.finddir(name, root_dir)
				if venv ~= "" then
					venv_selector.retrieve_from_cache()
					return
				end
			end
			local venv = vim.fn.findfile("pyproject.toml", root_dir)
			if venv ~= "" then
				venv_selector.retrieve_from_cache()
			end
		end,
		once = true,
	})
end

return M
