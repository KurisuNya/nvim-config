local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end
local noice_status, noice = pcall(require, "noice")
if not noice_status then
	return
end
vim.opt.showmode = false

local function diff_source()
	local vgit = vim.b.vgit_status
	if vgit then
		return {
			added = vgit.added,
			modified = vgit.changed,
			removed = vgit.removed,
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
lualine.setup({
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
			{ "branch", padding = { left = 1, right = 0 } },
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
