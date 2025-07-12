local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "linrongbin16/lsp-progress.nvim", opts = {} },
	},
	event = { "VeryLazy" },
}

PluginVars.lualine_hidden_lsp = {}
PluginVars.lualine_disabled_filetypes = {}

M.init = function()
	vim.opt.showmode = false
	vim.opt.ruler = false
	vim.opt.cmdheight = 0
	vim.g.lualine_laststatus = vim.o.laststatus
	if vim.fn.argc(-1) > 0 then
		vim.o.statusline = " "
	else
		vim.o.laststatus = 0
	end
end

M.config = function()
	local custom = require("plugins.editor.lualine.custom")
	local opts = {
		options = {
			theme = "auto",
			globalstatus = vim.o.laststatus == 3,
			section_separators = Config.lualine_section_separators,
			component_separators = Config.lualine_component_separators,
			disabled_filetypes = { statusline = PluginVars.lualine_disabled_filetypes },
		},
		extensions = { "lazy" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {
				"encoding",
				{ "fileformat", symbols = { unix = "LF ", dos = "CRLF ", mac = "CR " } },
				{ "filetype", cond = custom.space_enough },
			},
			lualine_y = { "progress" },
			lualine_z = {
				function()
					return "" .. os.date("%R")
				end,
			},
		},
	}

	-- extensions
	if Utils.plugin_exists("neo-tree.nvim") then
		table.insert(opts.extensions, "neo-tree")
	end
	if Utils.plugin_exists("nvim-dap-ui") then
		table.insert(opts.extensions, "nvim-dap-ui")
	end
	if Utils.plugin_exists("trouble.nvim") then
		local trouble_extension = {
			sections = {
				lualine_a = { "filetype" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			filetypes = { "trouble" },
		}
		table.insert(opts.extensions, trouble_extension)
	end
	if Utils.plugin_exists("toggleterm.nvim") then
		table.insert(opts.extensions, "toggleterm")
	end
	if Utils.plugin_exists("lspsaga.nvim") then
		local lspsaga_extension = {
			sections = {
				lualine_a = { "filetype" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			filetypes = { "sagaoutline" },
		}
		table.insert(opts.extensions, lspsaga_extension)
	end
	if Utils.plugin_exists("neotest") then
		local neotest_extension = {
			sections = {
				lualine_a = { "filetype" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			filetypes = { "neotest-summary" },
		}
		table.insert(opts.extensions, neotest_extension)
	end
	if Utils.plugin_exists("diffview.nvim") then
		local diffview_extension = {
			sections = {
				lualine_a = { "filetype" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			filetypes = { "DiffviewFiles" },
		}
		local diffview_history_extension = {
			sections = {
				lualine_a = { "filetype" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			filetypes = { "DiffviewFileHistory" },
		}
		table.insert(opts.extensions, diffview_extension)
		table.insert(opts.extensions, diffview_history_extension)
	end

	-- sections
	if Utils.plugin_exists("gitsigns.nvim") then
		local head = { "b:gitsigns_head", icon = "" }
		local diff = {
			"diff",
			source = function()
				---@diagnostic disable-next-line: undefined-field
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end,
			cond = custom.space_enough,
		}
		table.insert(opts.sections.lualine_b, head)
		table.insert(opts.sections.lualine_b, diff)
	end
	if Utils.plugin_exists("noice.nvim") then
		local noice = require("noice")
		local command = {
			noice.api.status.command.get,
			cond = noice.api.status.command.has,
			padding = { left = 1, right = 0 },
		}
		local mode = {
			noice.api.status.mode.get,
			cond = function()
				if not noice.api.status.mode.has() then
					return false
				elseif not noice.api.status.mode.get():find("@") then
					return false
				end
				return true
			end,
		}
		table.insert(opts.sections.lualine_c, command)
		table.insert(opts.sections.lualine_c, mode)
	end
	if Utils.plugin_exists("nvim-dap") then
		local dap_info = {
			custom.source.dap_info.provider,
			cond = custom.source.dap_info.cond,
			color = custom.source.dap_info.color,
		}
		table.insert(opts.sections.lualine_x, 1, dap_info)
	end
	if Utils.plugin_exists("lsp-progress.nvim") then
		local lsp_info = {
			custom.source.lsp_info.provider,
			cond = custom.source.lsp_info.cond,
			color = custom.source.lsp_info.color,
			icon = custom.source.lsp_info.icon,
		}
		table.insert(opts.sections.lualine_x, 1, lsp_info)
		custom.source.lsp_info.create_autocmd()
	end
	vim.o.laststatus = vim.g.lualine_laststatus
	require("lualine").setup(opts)
end

return M
