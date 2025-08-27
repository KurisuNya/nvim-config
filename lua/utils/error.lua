local M = {}

---Safely require a module with error handling
---@param module string The module name to require
---@return table|nil The required module or nil if failed
M.safe_require = function(module)
	local ok, result = pcall(require, module)
	if not ok then
		vim.notify("Failed to load " .. module .. ": " .. result, vim.log.levels.ERROR)
		return nil
	end
	return result
end

---Check if executable exists in PATH
---@param cmd string The command to check
---@return boolean True if executable exists
M.executable_exists = function(cmd)
	return vim.fn.executable(cmd) == 1
end

---Validate configuration table against schema
---@param config table The configuration to validate
---@param schema table The schema to validate against
---@return boolean True if valid, false otherwise
M.validate_config = function(config, schema)
	for key, expected_type in pairs(schema) do
		if config[key] ~= nil and type(config[key]) ~= expected_type then
			vim.notify(
				string.format("Invalid config: %s should be %s, got %s", key, expected_type, type(config[key])),
				vim.log.levels.ERROR
			)
			return false
		end
	end
	return true
end

---Measure execution time of a function
---@param fn function The function to measure
---@param name string Optional name for the measurement
---@return any The result of the function
M.measure_time = function(fn, name)
	local start_time = vim.fn.reltime()
	local result = fn()
	local end_time = vim.fn.reltime(start_time)
	local time_str = vim.fn.reltimestr(end_time)
	
	local msg = name and (name .. " took " .. time_str .. "s") or ("Operation took " .. time_str .. "s")
	vim.notify(msg, vim.log.levels.INFO)
	
	return result
end

return M