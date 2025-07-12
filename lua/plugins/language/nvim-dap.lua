---@diagnostic disable: missing-fields
local M = {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
}

PluginVars.dap_adapters = {}
PluginVars.dap_configurations = {}

M.init = function()
	PluginVars.insert(PluginVars.projections_close_filetypes, "dap_repl")
	PluginVars.insert(PluginVars.projections_close_filetypes, "dapui_console")
	PluginVars.insert(PluginVars.projections_close_filetypes, "dapui_stacks")
	PluginVars.insert(PluginVars.projections_close_filetypes, "dapui_scopes")
	PluginVars.insert(PluginVars.projections_close_filetypes, "dapui_breakpoints")
end

M.dependencies = {
	{ "nvim-neotest/nvim-nio" },
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dc", "<Cmd>DapContinue<CR>", desc = "Dap Continue", mode = "n", silent = true },
			{ "<leader>dt", "<Cmd>DapTerminate<CR>", desc = "Dap Terminate", mode = "n", silent = true },
			{ "<leader>]", "<Cmd>DapStepOver<CR>", desc = "Dap StepOver", mode = "n", silent = true },
			{ "<leader>}", "<Cmd>DapStepIn<CR>", desc = "Dap StepIn", mode = "n", silent = true },
			{ "<leader>{", "<Cmd>DapStepOut<CR>", desc = "Dap StepOut", mode = "n", silent = true },
		},
		dependencies = { "jay-babu/mason-nvim-dap.nvim", opts = { handlers = {} } },
		config = function()
			local dap = require("dap")
			for name, adapter in pairs(PluginVars.dap_adapters) do
				if type(adapter) == "table" then
					dap.adapters[name] = adapter
				elseif type(adapter) == "function" then
					dap.adapters[name] = adapter()
				else
					error("Invalid dap adapter for " .. name .. ": " .. type(adapter))
				end
			end
			for name, config in pairs(PluginVars.dap_configurations) do
				if type(config) == "table" then
					dap.configurations[name] = config
				elseif type(config) == "function" then
					dap.configurations[name] = config()
				else
					error("Invalid dap configuration for " .. name .. ": " .. type(config))
				end
			end
		end,
	},
	{
		"Weissle/persistent-breakpoints.nvim",
		keys = function()
			local breakpoints = require("persistent-breakpoints.api")
			vim.keymap.set("n", "<Leader>b", breakpoints.toggle_breakpoint, {
				noremap = true,
				silent = true,
				desc = "Breakpoints Toggle",
			})
			vim.keymap.set("n", "<Leader>B", breakpoints.clear_all_breakpoints, {
				noremap = true,
				silent = true,
				desc = "Breakpoints Clear All",
			})
		end,
		opts = { load_breakpoints_event = { "BufReadPost" } },
	},
	{
		"ofirgall/goto-breakpoints.nvim",
		keys = function()
			local goto_breakpoints = require("goto-breakpoints")
			vim.keymap.set("n", "]b", goto_breakpoints.next, {
				noremap = true,
				silent = true,
				desc = "Breakpoints Next",
			})
			vim.keymap.set("n", "[b", goto_breakpoints.prev, {
				noremap = true,
				silent = true,
				desc = "Breakpoints Previous",
			})
		end,
	},
	{ "theHamsta/nvim-dap-virtual-text", opts = {} },
}

M.keys = function()
	local nvim_dap_ui = require("dapui")
	vim.keymap.set("n", "<leader>du", function()
		nvim_dap_ui.toggle({ reset = true })
		PluginVars.dapui_opened = not PluginVars.dapui_opened
	end, { noremap = true, silent = true, desc = "Dap UI Toggle" })

	vim.keymap.set("n", "<leader>de", function()
		nvim_dap_ui.eval()
	end, { noremap = true, silent = true, desc = "Dap UI Eval" })
end

local normal_mappings = {
	edit = "e",
	expand = { "<CR>", "<2-LeftMouse>" },
	open = "o",
	remove = "d",
	repl = "r",
	toggle = "t",
}
local float_mappings = { close = { "q", "<Esc>" } }

M.config = function()
	PluginVars.dapui_opened = false
	local nvim_dap = require("dap")
	local nvim_dap_ui = require("dapui")

	nvim_dap_ui.setup({
		force_buffers = true,
		icons = {
			expanded = Icons.ui.ArrowOpen,
			collapsed = Icons.ui.ArrowClose,
			current_frame = Icons.ui.Indicator,
		},
		mappings = normal_mappings,
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.76 },
					{ id = "breakpoints", size = 0.24 },
				},
				size = 0.25,
				position = "right",
			},
			{
				elements = {
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
				pause = Icons.dap.Pause,
				play = Icons.dap.Play,
				step_into = Icons.dap.StepInto,
				step_over = Icons.dap.StepOver,
				step_out = Icons.dap.StepOut,
				step_back = Icons.dap.StepBack,
				run_last = Icons.dap.RunLast,
				terminate = Icons.dap.Terminate,
			},
		},
		floating = {
			max_height = 0.5,
			max_width = 0.5,
			border = Config.border_style,
			mappings = float_mappings,
		},
		render = { indent = 1, max_value_lines = 85 },
	})

	nvim_dap.listeners.after.event_initialized["dapui_config"] = function()
		nvim_dap_ui.open({ reset = true })
		PluginVars.dapui_opened = true
	end
	nvim_dap.listeners.before.event_terminated["dapui_config"] = function()
		nvim_dap_ui.close()
		PluginVars.dapui_opened = false
	end
	nvim_dap.listeners.before.event_exited["dapui_config"] = function()
		nvim_dap_ui.close()
		PluginVars.dapui_opened = false
	end
	vim.api.nvim_create_autocmd({ "VimResized" }, {
		group = Utils.create_augroup("dap_resize_ui"),
		callback = function()
			if PluginVars.dapui_opened then
				nvim_dap_ui.toggle({ reset = true })
				nvim_dap_ui.toggle({ reset = true })
			end
		end,
	})

	vim.fn.sign_define("DapBreakpoint", {
		text = Icons.dap.BreakPoint,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapBreakpointCondition", {
		text = Icons.dap.BreakPointCondition,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = Icons.dap.BreakPointRejected,
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	})
	vim.fn.sign_define("DapLogPoint", {
		text = Icons.dap.LogPoint,
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	})
	vim.fn.sign_define("DapStopped", {
		text = Icons.dap.Stopped,
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	})
end
return M
