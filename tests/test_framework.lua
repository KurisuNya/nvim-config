-- Simple test framework for Neovim configuration
local M = {}

M.tests = {}
M.results = { passed = 0, failed = 0, errors = {} }

-- Add a test case
M.test = function(name, fn)
	table.insert(M.tests, { name = name, fn = fn })
end

-- Assert function
M.assert = function(condition, message)
	if not condition then
		error(message or "Assertion failed")
	end
end

-- Assert equality
M.assert_eq = function(actual, expected, message)
	if actual ~= expected then
		error(message or ("Expected " .. tostring(expected) .. ", got " .. tostring(actual)))
	end
end

-- Assert table equality (simple version)
M.assert_table_eq = function(actual, expected, message)
	if vim.deep_equal and not vim.deep_equal(actual, expected) then
		error(message or "Tables are not equal")
	elseif not vim.deep_equal then
		-- Fallback for older Neovim versions
		if type(actual) ~= "table" or type(expected) ~= "table" then
			M.assert_eq(actual, expected, message)
			return
		end
		for k, v in pairs(expected) do
			if actual[k] ~= v then
				error(message or ("Tables differ at key " .. tostring(k)))
			end
		end
	end
end

-- Run all tests
M.run_all = function()
	M.results = { passed = 0, failed = 0, errors = {} }
	
	print("Running " .. #M.tests .. " tests...")
	
	for _, test in ipairs(M.tests) do
		local ok, err = pcall(test.fn)
		if ok then
			M.results.passed = M.results.passed + 1
			print("✓ " .. test.name)
		else
			M.results.failed = M.results.failed + 1
			table.insert(M.results.errors, { name = test.name, error = err })
			print("✗ " .. test.name .. " - " .. err)
		end
	end
	
	print(string.format("\nResults: %d passed, %d failed", M.results.passed, M.results.failed))
	
	if M.results.failed > 0 then
		print("\nFailures:")
		for _, failure in ipairs(M.results.errors) do
			print("  " .. failure.name .. ": " .. failure.error)
		end
	end
	
	return M.results.failed == 0
end

return M