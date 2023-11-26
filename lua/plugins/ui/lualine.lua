---@diagnostic disable: undefined-field
local M = {}
M.config = function()
	local lualine_theme = require("core.colorscheme").lualine
	local custom = require("plugins.ui.lualine-custom")
	local noice = require("noice")

	vim.opt.showmode = false
	vim.o.laststatus = vim.g.lualine_laststatus
	custom.source.lsp_info.create_autocmd()

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
			"toggleterm",
			custom.extensions.diffview,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "b:gitsigns_head", icon = "" },
				{
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
				},
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
					custom.source.lsp_info.provider,
					cond = custom.source.lsp_info.cond,
					color = custom.source.lsp_info.color,
					icon = custom.source.lsp_info.icon,
				},
				{
					custom.source.dap_info.provider,
					cond = custom.source.dap_info.cond,
					color = custom.source.dap_info.color,
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
				{
					"filetype",
					cond = custom.utils.space_enough,
				},
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
