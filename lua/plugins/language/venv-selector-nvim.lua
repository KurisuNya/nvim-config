local M = {}
M.config = function()
	local opts = { settings = { search = {} } }
	if not KurisuNya.utils.is_windows() then
		opts.settings.search.pyenv = {
			command = "$FD '/bin/python$' ~/.pyenv --full-path --color never -L -E /proc -E envs",
		}
	end
	require("venv-selector").setup(opts)
end
return M
