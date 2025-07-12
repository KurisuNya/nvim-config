-- stylua: ignore start
local space_enough_cond = {
	function() return vim.o.columns >= 100 end,
}
if Utils.plugin_exists("diffview.nvim") then
	table.insert(space_enough_cond, function() return not PluginVars.diffview_opened end)
end
-- stylua: ignore end
local lsp_info_max_length = { base = 80, cond = {} }
if Utils.plugin_exists("nvim-dap-ui") then
	local cond = function()
		if PluginVars.dapui_opened then
			return -30
		end
		return 0
	end
	table.insert(lsp_info_max_length.cond, cond)
end

local function space_enough()
	for _, cond in ipairs(space_enough_cond) do
		if not cond() then
			return false
		end
	end
	return true
end

local function lsp_get_max_length()
	local len = lsp_info_max_length.base
	for _, cond in ipairs(lsp_info_max_length.cond) do
		local result = cond()
		if result then
			len = len + result
		end
	end
	return len
end

local function lsp_get_client_name()
	local function is_hidden_client(client_name)
		for _, name in ipairs(PluginVars.lualine_hidden_lsp) do
			if client_name == name then
				return true
			end
		end
		return false
	end

	local client_names = {}
	local all_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
	for _, client in ipairs(all_clients) do
		if client and client.name ~= "" and not is_hidden_client(client.name) then
			table.insert(client_names, 1, client.name)
		end
	end
	return table.concat(client_names, ",")
end

local function lsp_messages_formatter(messages)
	local function to_pattern(str)
		local new_str = str:gsub("%%", "%%%%")
		local special_chars = {
			["%^"] = "%%^",
			["%("] = "%%(",
			["%)"] = "%%)",
			["%["] = "%%[",
			["%]"] = "%%]",
			["%$"] = "%%$",
			["%."] = "%%.",
			["%*"] = "%%*",
			["%+"] = "%%+",
			["%-"] = "%%-",
			["%?"] = "%%?",
		}
		for k, v in pairs(special_chars) do
			new_str = new_str:gsub(k, v)
		end
		return new_str
	end

	local function get_useful_message(messages)
		if #messages == 0 then
			return nil
		end
		if not messages[1]:find("%d") then
			return nil
		end
		for _, client in ipairs(PluginVars.lualine_hidden_lsp) do
			if messages[1]:find(to_pattern(client)) then
				return nil
			end
		end
		return messages[1]
	end

	local message = get_useful_message(messages)
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

local is_dap_started = function()
	return Utils.plugin_loaded("nvim-dap") and require("dap").status() ~= ""
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
			return not is_dap_started() and space_enough()
		end,
		color = { fg = Utils.get_hl_color("LualineLsp", "fg#") },
		icon = { "", align = "right", padding = { left = 0, right = 1 } },
		create_autocmd = function()
			vim.api.nvim_create_autocmd("User", {
				group = Utils.create_augroup("refresh_lsp_progress"),
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
			return is_dap_started() and space_enough()
		end,
		color = { fg = Utils.get_hl_color("LualineDebug", "fg#") },
	},
}
M.space_enough = space_enough
return M
