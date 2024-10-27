---@diagnostic disable: undefined-field
local M = {}
M.config = function()
	local custom = require("plugins.ui.lualine-custom")
	local opts = {
		options = {
			globalstatus = vim.o.laststatus == 3,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
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
	if KurisuNya.utils.plugin_exist("neo-tree.nvim") then
		table.insert(opts.extensions, "neo-tree")
	end
	if KurisuNya.utils.plugin_exist("nvim-dap-ui") then
		table.insert(opts.extensions, "nvim-dap-ui")
	end
	if KurisuNya.utils.plugin_exist("trouble.nvim") then
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
	if KurisuNya.utils.plugin_exist("toggleterm.nvim") then
		table.insert(opts.extensions, "toggleterm")
	end
	if KurisuNya.utils.plugin_exist("neotest") then
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
	if KurisuNya.utils.plugin_exist("diffview.nvim") then
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
	if KurisuNya.utils.plugin_exist("gitsigns.nvim") then
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
	if KurisuNya.utils.plugin_exist("noice.nvim") then
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
	if KurisuNya.utils.plugin_exist("nvim-dap") then
		local dap_info = {
			custom.source.dap_info.provider,
			cond = custom.source.dap_info.cond,
			color = custom.source.dap_info.color,
		}
		table.insert(opts.sections.lualine_x, 1, dap_info)
	end
	if KurisuNya.utils.plugin_exist("lsp-progress.nvim") then
		local lsp_info = {
			custom.source.lsp_info.provider,
			cond = custom.source.lsp_info.cond,
			color = custom.source.lsp_info.color,
			icon = custom.source.lsp_info.icon,
		}
		table.insert(opts.sections.lualine_x, 1, lsp_info)
	end

	vim.o.laststatus = vim.g.lualine_laststatus
	custom.source.lsp_info.create_autocmd()
	require("lualine").setup(opts)
end
return M
