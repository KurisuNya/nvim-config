---@diagnostic disable: undefined-doc-name, assign-type-mismatch
local M = {}
M.config = function()
	local has_trouble = require("lazy.core.config").spec.plugins["trouble.nvim"] ~= nil
	local has_venv_selector = require("lazy.core.config").spec.plugins["venv-selector.nvim"] ~= nil

	local opts = {
		quickfix = {
			open = function()
				if has_trouble then
					require("trouble").open({ mode = "quickfix", focus = false })
				else
					vim.cmd("copen")
				end
			end,
		},
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				runner = "pytest",
				python = function()
					if has_venv_selector then
						return require("venv-selector").get_active_path()
					end
				end,
			}),
		},
		summary = {
			open = "botright vsplit | vertical resize 40",
		},
	}

	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				-- Replace newline and tab characters with space for more compact diagnostics
				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				return message
			end,
		},
	}, neotest_ns)

	opts.consumers = opts.consumers or {}
	if has_trouble then
		-- Refresh and auto close trouble after running tests
		---@type neotest.Consumer
		opts.consumers.trouble = function(client)
			client.listeners.results = function(adapter_id, results, partial)
				if partial then
					return
				end
				local tree = assert(client:get_position(nil, { adapter = adapter_id }))

				local failed = 0
				for pos_id, result in pairs(results) do
					if result.status == "failed" and tree:get_key(pos_id) then
						failed = failed + 1
					end
				end
				vim.schedule(function()
					local trouble = require("trouble")
					if trouble.is_open() then
						trouble.refresh()
						if failed == 0 then
							trouble.close()
						end
					end
				end)
				return {}
			end
		end
	end
	require("neotest").setup(opts)
end
return M
