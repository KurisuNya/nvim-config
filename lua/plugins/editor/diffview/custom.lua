PluginVars.diffview_opened = false
PluginVars.diffview_open_hooks = {}
PluginVars.diffview_close_hooks = {}

local function get_buffers()
	local buffers = {}
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.buflisted(buffer) == 1 then
			table.insert(buffers, buffer)
		end
	end
	return buffers
end

local M = {}

local original_buffers = {}

M.diffview_view_opened_hook = function()
	PluginVars.diffview_opened = true
	for _, func in ipairs(PluginVars.diffview_open_hooks) do
		func()
	end
	original_buffers = get_buffers()
	for _, buffer in ipairs(original_buffers) do
		vim.api.nvim_set_option_value("buflisted", false, { buf = buffer })
	end
end

M.diffview_view_close_hook = function()
	PluginVars.diffview_opened = false
	for _, func in ipairs(PluginVars.diffview_close_hooks) do
		func()
	end
	for _, buffer in ipairs(get_buffers()) do
		if not vim.tbl_contains(original_buffers, buffer) then
			vim.api.nvim_buf_delete(buffer, { force = true })
		end
	end
	for _, buffer in ipairs(original_buffers) do
		vim.api.nvim_set_option_value("buflisted", true, { buf = buffer })
	end
end

return M
