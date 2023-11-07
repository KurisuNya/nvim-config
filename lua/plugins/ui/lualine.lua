local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end
local noice_status, noice = pcall(require, "noice")
if not noice_status then
	return
end
local icons = require("plugins.ui.icons")
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

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ""
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
		end
		return str
	end
end

local lualine_theme = require("core.colorscheme").lualine
lualine.setup({
	options = {
		theme = lualine_theme,
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	extensions = { "neo-tree", "trouble", "toggleterm" },
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = {
			{ "b:gitsigns_head", icon = icons.git.Head },
			{ "diff", source = diff_source },
		},
		lualine_c = {
			{
				noice.api.status.command.get,
				cond = noice.api.status.command.has,
			},
			{
				noice.api.status.mode.get,
				cond = noice.api.status.mode.has,
			},
		},
		lualine_x = {
			"encoding",
			{
				"fileformat",
				symbols = {
					unix = "LF ",
					dos = "CRLF ",
					mac = "CR ",
				},
			},
			"filetype",
		},
		lualine_z = {
			{ "filename", fmt = trunc(90, 30, 50) },
		},
	},
})
