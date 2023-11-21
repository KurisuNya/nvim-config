---@diagnostic disable: undefined-field
local M = {}
M.config = function()
	local lualine_theme = require("core.colorscheme").lualine
	local noice = require("noice")
	vim.opt.showmode = false

	-- usful function
	local function space_enough()
		if vim.o.columns > 100 and not _G.diffview_opened then
			return true
		end
		return false
	end

	local function get_fg(name)
		local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
			or vim.api.nvim_get_hl_by_name(name, true)
		local fg = hl and (hl.fg or hl.foreground)
		return fg and { fg = string.format("#%06x", fg) } or nil
	end

	local function lsp_get_client_name()
		local client_names = {}
		for _, client in ipairs(vim.lsp.get_active_clients()) do
			if client and client.name ~= "" and client.name ~= "null-ls" then
				table.insert(client_names, 1, client.name)
			end
		end
		return table.concat(client_names, ",")
	end

	local function lsp_get_useful_message(messages)
		if #messages == 0 then
			return nil
		end
		local from, _ = messages[1]:find("%d")
		if not from then
			return nil
		end
		return messages[1]
	end

	local function lsp_messages_formater(messages)
		local message = lsp_get_useful_message(messages)
		if not message then
			return lsp_get_client_name()
		end
		local from, _ = message:find(",")
		if from then
			message = message:sub(1, from - 1)
		end
		from, _ = message:find(" %- done")
		if from then
			message = message:sub(1, from - 1)
		end
		return message
	end

	local function get_max_size()
		if _G._debugui then
			return 50
		end
		return 80
	end

	-- custom source
	local function lsp_info()
		return require("lsp-progress").progress({
			max_size = get_max_size(),
			format = lsp_messages_formater,
		})
	end
	vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		group = "lualine_augroup",
		pattern = "LspProgressStatusUpdated",
		callback = require("lualine").refresh,
	})

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

	local diffview = {
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
			diffview,
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
					lsp_info,
					cond = function()
						return not package.loaded["dap"] or require("dap").status() == "" and space_enough()
					end,
					color = get_fg("Comment"),
					icon = { "", align = "right", padding = { left = 0, right = 1 } },
				},
				{
					function()
						return " " .. require("dap").status()
					end,
					cond = function()
						return package.loaded["dap"] and require("dap").status() ~= "" and space_enough()
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
				{
					"filetype",
					cond = space_enough,
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
