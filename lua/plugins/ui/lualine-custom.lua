local function space_enough()
	if vim.o.columns < 100 then
		return false
	end
	return true
end
if KurisuNya.utils.plugin_exist("diffview.nvim") then
	local old_space_enough = space_enough
	space_enough = function()
		if old_space_enough() and not PluginVar.diffview_opened then
			return true
		end
		return false
	end
end

local function lsp_get_max_length()
	return 80
end
if KurisuNya.utils.plugin_exist("nvim-dap-ui") then
	local new_lsp_get_max_length = function()
		if PluginVar.debugui then
			return 50
		end
		return 80
	end
	lsp_get_max_length = new_lsp_get_max_length
end

local function lsp_get_client_name()
	local function is_hidden_client(client_name)
		for _, name in ipairs(KurisuNya.config.lualine_hidden_lsp) do
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
		for _, client in ipairs(KurisuNya.config.lualine_hidden_lsp) do
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
	return KurisuNya.utils.plugin_loaded("nvim-dap") and require("dap").status() ~= ""
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
		color = { fg = KurisuNya.utils.get_hl_color("Comment", "fg#") },
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
			return is_dap_started() and space_enough()
		end,
		color = { fg = KurisuNya.utils.get_hl_color("Debug", "fg#") },
	},
}
M.space_enough = space_enough
return M
