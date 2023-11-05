---@diagnostic disable: missing-fields
local nvim_dap_status, nvim_dap = pcall(require, "dap")
if not nvim_dap_status then
	return
end
local nvim_dap_ui_status, nvim_dap_ui = pcall(require, "dapui")
if not nvim_dap_ui_status then
	return
end
local icons = require("plugins.ui.icons")
local map_list = require("core.keymaps").nvim_dap_ui

nvim_dap_ui.setup({
	force_buffers = true,
	icons = {
		expanded = icons.ui.arrow_open,
		collapsed = icons.ui.arrow_close,
		current_frame = icons.ui.indicator,
	},
	mappings = map_list.normal_mappings,
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.76,
				},
				{ id = "breakpoints", size = 0.24 },
			},
			size = 0.25,
			position = "right",
		},
		{
			elements = {
				-- { id = "watches", size = 0.3 },
				{ id = "console", size = 0.4 },
				{ id = "repl", size = 0.3 },
				{ id = "stacks", size = 0.3 },
			},
			position = "bottom",
			size = 0.25,
		},
	},
	controls = {
		enabled = true,
		element = "repl",
		icons = {
			pause = icons.dap.pause,
			play = icons.dap.play,
			step_into = icons.dap.step_into,
			step_over = icons.dap.step_over,
			step_out = icons.dap.step_out,
			step_back = icons.dap.step_back,
			run_last = icons.dap.run_last,
			terminate = icons.dap.terminate,
		},
	},
	floating = {
		max_height = 0.5,
		max_width = 0.5,
		border = "rounded",
		mappings = map_list.float_mappings,
	},
	render = { indent = 1, max_value_lines = 85 },
})
nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
	nvim_dap_ui.open({ reset = true })
end
nvim_dap.listeners.before.event_terminated["dapui_config"] = function()
	nvim_dap_ui.close()
end
nvim_dap.listeners.before.event_exited["dapui_config"] = function()
	nvim_dap_ui.close()
end

local function get_color(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
vim.api.nvim_set_hl(0, "DapBreakpoint", {
	ctermbg = 0,
	fg = get_color("DiagnosticError", "fg#"),
	bg = get_color("CursorLine", "bg#"),
})
vim.api.nvim_set_hl(0, "DapLogPoint", {
	ctermbg = 0,
	fg = get_color("DiagnosticInfo", "fg#"),
	bg = get_color("CursorLine", "bg#"),
})
vim.api.nvim_set_hl(0, "DapStopped", {
	ctermbg = 0,
	fg = get_color("diagnosticHint", "fg#"),
	bg = get_color("CursorLine", "bg#"),
})
vim.fn.sign_define("DapBreakpoint", {
	text = icons.dap.break_point,
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = icons.dap.break_point_condition,
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = icons.dap.break_point_rejected,
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapLogPoint", {
	text = icons.dap.log_point,
	texthl = "DapLogPoint",
	linehl = "DapLogPoint",
	numhl = "DapLogPoint",
})
vim.fn.sign_define("DapStopped", {
	text = icons.dap.stopped,
	texthl = "DapStopped",
	linehl = "DapStopped",
	numhl = "DapStopped",
})
