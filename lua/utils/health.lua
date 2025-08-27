local M = {}

---Check health of core dependencies
M.check_dependencies = function()
	local error_utils = require("utils.error")
	
	local required_executables = {
		"git",
		"node", 
		"python3",
		"rg", -- ripgrep for telescope
		"fd", -- fd for telescope
	}
	
	local missing = {}
	for _, cmd in ipairs(required_executables) do
		if not error_utils.executable_exists(cmd) then
			table.insert(missing, cmd)
		end
	end
	
	if #missing > 0 then
		vim.notify(
			"Missing dependencies: " .. table.concat(missing, ", "),
			vim.log.levels.WARN,
			{ title = "Health Check" }
		)
		return false
	end
	
	vim.notify("All dependencies found ✓", vim.log.levels.INFO, { title = "Health Check" })
	return true
end

---Check plugin loading status
M.check_plugins = function()
	local plugins = require("lazy.core.config").plugins
	local failed = {}
	
	for name, plugin in pairs(plugins) do
		if plugin._.loaded == false and not plugin.lazy then
			table.insert(failed, name)
		end
	end
	
	if #failed > 0 then
		vim.notify(
			"Failed to load plugins: " .. table.concat(failed, ", "),
			vim.log.levels.ERROR,
			{ title = "Plugin Health" }
		)
		return false
	end
	
	vim.notify("All plugins loaded successfully ✓", vim.log.levels.INFO, { title = "Plugin Health" })
	return true
end

---Run comprehensive health check
M.check_all = function()
	vim.notify("Running health checks...", vim.log.levels.INFO, { title = "Health Check" })
	
	local deps_ok = M.check_dependencies()
	local plugins_ok = M.check_plugins()
	
	if deps_ok and plugins_ok then
		vim.notify("All health checks passed ✓", vim.log.levels.INFO, { title = "Health Check" })
	else
		vim.notify("Some health checks failed ⚠️", vim.log.levels.WARN, { title = "Health Check" })
	end
end

return M