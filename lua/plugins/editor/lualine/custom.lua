local space_enough_cond = {
	function()
		return vim.o.columns >= 100
	end,
}
if Utils.plugin_exists("diffview.nvim") then
	table.insert(space_enough_cond, function()
		return not PluginVars.diffview_opened
	end)
end

local function space_enough()
	for _, cond in ipairs(space_enough_cond) do
		if not cond() then
			return false
		end
	end
	return true
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
	return table.concat(client_names, ", ")
end

local is_dap_started = function()
	return Utils.plugin_loaded("nvim-dap") and require("dap").status() ~= ""
end

local M = {}
M.source = {
	lsp_info = {
		provider = lsp_get_client_name,
		cond = space_enough,
		color = { fg = Utils.get_hl_color("LualineLsp", "fg#") },
		icon = { "", align = "right", padding = { left = 0, right = 1 } },
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
