-- Tests for utility functions
local test = require("tests.test_framework")

-- Test the tbl_filter_same function
test.test("Utils.tbl_filter_same removes duplicates", function()
	local utils = require("utils.utils")
	local input = { 1, 2, 2, 3, 1, 4, 3 }
	local expected = { 1, 2, 3, 4 }
	local result = utils.tbl_filter_same(input)
	test.assert_table_eq(result, expected)
end)

-- Test the tbl_filter_same function with strings
test.test("Utils.tbl_filter_same works with strings", function()
	local utils = require("utils.utils")
	local input = { "a", "b", "a", "c", "b" }
	local expected = { "a", "b", "c" }
	local result = utils.tbl_filter_same(input)
	test.assert_table_eq(result, expected)
end)

-- Test OS detection
test.test("Utils.get_os returns a string", function()
	local utils = require("utils.utils")
	local os_name = utils.get_os()
	test.assert(type(os_name) == "string", "OS name should be a string")
	test.assert(#os_name > 0, "OS name should not be empty")
end)

-- Test plugin_exists function (will only work if lazy is loaded)
test.test("Utils.plugin_exists can check for plugins", function()
	local utils = require("utils.utils")
	-- This should not error, regardless of result
	local exists = utils.plugin_exists("nonexistent-plugin")
	test.assert(type(exists) == "boolean", "plugin_exists should return boolean")
end)

-- Test create_augroup function
test.test("Utils.create_augroup creates unique group", function()
	local utils = require("utils.utils")
	local group_id = utils.create_augroup("test_group")
	test.assert(type(group_id) == "number", "create_augroup should return number")
	test.assert(group_id > 0, "Group ID should be positive")
end)

-- Test error utils
test.test("ErrorUtils.executable_exists works", function()
	local error_utils = require("utils.error")
	-- Test with a command that should exist
	local exists = error_utils.executable_exists("ls")
	test.assert(type(exists) == "boolean", "executable_exists should return boolean")
end)

test.test("ErrorUtils.safe_require handles missing modules", function()
	local error_utils = require("utils.error")
	local result = error_utils.safe_require("nonexistent.module")
	test.assert(result == nil, "safe_require should return nil for missing modules")
end)

test.test("ErrorUtils.safe_require loads existing modules", function()
	local error_utils = require("utils.error")
	local result = error_utils.safe_require("utils.utils")
	test.assert(result ~= nil, "safe_require should return module for existing modules")
	test.assert(type(result) == "table", "Loaded module should be a table")
end)

-- If this file is run directly, execute the tests
if vim.v.progname == "nvim" then
	return test.run_all()
end

return test