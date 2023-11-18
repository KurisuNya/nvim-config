---@diagnostic disable: missing-fields
local M = {}
M.config = function()
	local nvim_dap = require("dap")
	local nvim_dap_ui = require("dapui")
	local icons = require("plugins.ui.icons")
	local map_list = require("core.keymaps.nvim-dap-ui")

	nvim_dap_ui.setup({
		force_buffers = true,
		icons = {
			expanded = icons.ui.ArrowOpen,
			collapsed = icons.ui.ArrowClose,
			current_frame = icons.ui.Indicator,
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
				pause = icons.dap.Pause,
				play = icons.dap.Play,
				step_into = icons.dap.StepInto,
				step_over = icons.dap.StepOver,
				step_out = icons.dap.StepOut,
				step_back = icons.dap.StepBack,
				run_last = icons.dap.RunLast,
				terminate = icons.dap.Terminate,
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
		_G._debugui = true
	end
	nvim_dap.listeners.before.event_terminated["dapui_config"] = function()
		nvim_dap_ui.close()
		_G._debugui = false
	end
	nvim_dap.listeners.before.event_exited["dapui_config"] = function()
		nvim_dap_ui.close()
		_G._debugui = false
	end
	vim.api.nvim_create_autocmd({ "VimResized" }, {
		group = vim.api.nvim_create_augroup("ResizeDapUI", { clear = true }),
		callback = function()
			if _G._debugui then
				nvim_dap_ui.toggle({ reset = true })
				nvim_dap_ui.toggle({ reset = true })
			end
		end,
	})

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
		text = icons.dap.BreakPoint,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapBreakpointCondition", {
		text = icons.dap.BreakPointCondition,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = icons.dap.BreakPointRejected,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapLogPoint", {
		text = icons.dap.LogPoint,
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	})
	vim.fn.sign_define("DapStopped", {
		text = icons.dap.Stopped,
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	})
end
return M
