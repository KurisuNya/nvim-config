local function get_color(group, attr)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

local function space_enough()
	if vim.o.columns > 100 and not _G.diffview_opened then
		return true
	end
	return false
end

local lsp_hidden_client = {
	"null-ls",
}

local function lsp_is_hidden_client(client_name)
	for _, name in ipairs(lsp_hidden_client) do
		if client_name == name then
			return true
		end
	end
	return false
end

local function lsp_get_client_name()
	local client_names = {}
	for _, client in ipairs(vim.lsp.get_active_clients()) do
		if client and client.name ~= "" and not lsp_is_hidden_client(client.name) then
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

local function lsp_messages_formatter(messages)
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

local function lsp_get_max_length()
	if _G._debugui then
		return 50
	end
	return 80
end

local M = {}

M.source = {
	lsp_info = {
		provider = function()
			return require("lsp-progress").progress({
				max_size = lsp_get_max_length(),
				format = lsp_messages_formatter,
			})
		end,
		cond = function()
			return not package.loaded["dap"] or require("dap").status() == "" and space_enough()
		end,
		color = { fg = get_color("Comment", "fg#") },
		icon = { "", align = "right", padding = { left = 0, right = 1 } },
		create_autocmd = function()
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end,
	},

	dap_info = {
		provider = function()
			return " " .. require("dap").status()
		end,
		cond = function()
			return package.loaded["dap"] and require("dap").status() ~= "" and space_enough()
		end,
		color = { fg = get_color("Debug", "fg#") },
	},
}

M.extensions = {
	diffview = {
		sections = {
			lualine_a = { "filetype" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		filetypes = { "DiffviewFiles" },
	},
}

M.utils = {
	space_enough = space_enough,
}

return M
