---@diagnostic disable: undefined-field
local M = {}
M.config = function()
	vim.opt.showmode = false
	local function diff_source()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed,
			}
		end
	end
	local function get_fg(name)
		local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
			or vim.api.nvim_get_hl_by_name(name, true)
		local fg = hl and (hl.fg or hl.foreground)
		return fg and { fg = string.format("#%06x", fg) } or nil
	end
	local lualine_theme = require("core.colorscheme").lualine
	local noice = require("noice")

	require("lualine").setup({
		options = {
			theme = lualine_theme,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		extensions = {
			"lazy",
			"neo-tree",
			"nvim-dap-ui",
			"trouble",
		},
		sections = {
			lualine_a = {
				"mode",
			},
			lualine_b = {
				{ "b:gitsigns_head", icon = "" },
				{ "diff", source = diff_source },
			},
			lualine_c = {
				{
					noice.api.status.command.get,
					cond = noice.api.status.command.has,
					padding = { left = 1, right = 0 },
				},
				{
					noice.api.status.mode.get,
					cond = noice.api.status.mode.has,
				},
			},
			lualine_x = {
				{
					function()
						return " " .. require("dap").status()
					end,
					cond = function()
						return package.loaded["dap"] and require("dap").status() ~= ""
					end,
					color = get_fg("Debug"),
				},
				"encoding",
				{
					"fileformat",
					symbols = {
						unix = "LF ",
						dos = "CRLF ",
						mac = "CR ",
					},
				},
				"filetype",
			},
			lualine_y = {
				"progress",
			},
			lualine_z = {
				function()
					return "" .. os.date("%R")
				end,
			},
		},
	})
end
return M
