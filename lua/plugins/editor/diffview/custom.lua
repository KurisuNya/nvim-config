PluginVars.diffview_opened = false
PluginVars.diffview_open_hooks = {}
PluginVars.diffview_close_hooks = {}

local GIT_INFO_TYPE = { error = -2, untraced = -1, nochange = 0, changed = 1 }

local function get_git_info()
	local gitsigns = vim.b.gitsigns_status_dict
	if not gitsigns then
		return GIT_INFO_TYPE.error
	end
	if not gitsigns.added or not gitsigns.changed or not gitsigns.removed then
		return GIT_INFO_TYPE.untraced
	end
	if gitsigns.added == 0 and gitsigns.changed == 0 and gitsigns.removed == 0 then
		return GIT_INFO_TYPE.nochange
	end
	return GIT_INFO_TYPE.changed
end

local function get_buffers()
	local buffers = {}
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.buflisted(buffer) == 1 then
			table.insert(buffers, buffer)
		end
	end
	return buffers
end

local function none_project_notify()
	vim.notify("Only can be used in project mode.", vim.log.levels.WARN, { title = "Diffview" })
end

local M = {}

local diffview_open_project = false

M.diffview_open_current = function()
	if PluginVars.diffview_opened then
		return
	end
	if vim.o.filetype == "" then
		vim.notify("Not a file.", vim.log.levels.ERROR, { title = "Diffview" })
		return
	end
	local git_info = get_git_info()
	if git_info == GIT_INFO_TYPE.untraced then
		vim.notify("Untraced file.", vim.log.levels.WARN, { title = "Diffview" })
		return
	elseif git_info == GIT_INFO_TYPE.nochange then
		vim.notify("File has no change.", vim.log.levels.WARN, { title = "Diffview" })
		return
	end

	diffview_open_project = false
	vim.cmd("DiffviewOpen")
end

M.diffview_open_project = function()
	if PluginVars.diffview_opened then
		return
	end
	diffview_open_project = true
	vim.cmd("DiffviewOpen")
end

M.diffview_open_history = function()
	if PluginVars.diffview_opened then
		return
	end
	diffview_open_project = true
	vim.cmd("DiffviewFileHistory")
end

M.diffview_next_entry = function()
	if diffview_open_project then
		require("diffview.actions").select_next_entry()
	else
		none_project_notify()
	end
end

M.diffview_prev_entry = function()
	if diffview_open_project then
		require("diffview.actions").select_prev_entry()
	else
		none_project_notify()
	end
end

M.diffview_toggle_files = function()
	if diffview_open_project then
		require("diffview.actions").toggle_files()
	else
		none_project_notify()
	end
end

M.diffview_stage_hunk = function()
	if diffview_open_project then
		vim.cmd("Gitsigns stage_hunk")
	else
		none_project_notify()
	end
end

M.diffview_stage_buffer = function()
	if diffview_open_project then
		vim.cmd("Gitsigns stage_buffer")
	else
		none_project_notify()
	end
end

M.diffview_undo_stage_hunk = function()
	if diffview_open_project then
		vim.cmd("Gitsigns undo_stage_hunk")
	else
		none_project_notify()
	end
end

M.diffview_undo_stage_all = function()
	if diffview_open_project then
		require("diffview.actions").unstage_all()
	else
		none_project_notify()
	end
end

M.diffview_prev_conflict = function()
	if diffview_open_project then
		require("diffview.actions").prev_conflict()
	else
		none_project_notify()
	end
end

M.diffview_next_conflict = function()
	if diffview_open_project then
		require("diffview.actions").next_conflict()
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_ours = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose("ours")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_theirs = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose("theirs")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_base = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose("base")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose("all")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_none = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose("none")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all_ours = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose_all("ours")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all_theirs = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose_all("theirs")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all_base = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose_all("base")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all_all = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose_all("all")
	else
		none_project_notify()
	end
end

M.diffview_conflict_choose_all_none = function()
	if diffview_open_project then
		require("diffview.actions").conflict_choose_all("none")
	else
		none_project_notify()
	end
end

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
	if not diffview_open_project then
		require("diffview.actions").toggle_files()
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
		vim.api.nvim_buf_call(buffer, function()
			vim.opt_local.rnu = true
			vim.opt_local.signcolumn = "yes"
		end)
	end
end

M.diffview_buffer_read_hook = function()
	vim.opt_local.rnu = false
	vim.opt_local.signcolumn = "no"
	vim.cmd("normal !gg")
end

return M
