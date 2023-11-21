local actions = require("diffview.actions")

local GIT_INFO_TYPE = {
	error = -2,
	untraced = -1,
	nochange = 0,
	changed = 1,
}

local function get_git_info()
	---@diagnostic disable-next-line: undefined-field
	local gitsigns = vim.b.gitsigns_status_dict
	if not gitsigns then
		return GIT_INFO_TYPE.error
	end
	if not gitsigns.added or not gitsigns.changed or not gitsigns.removed then
		return GIT_INFO_TYPE.untraced
	end
	if gitsigns.added ~= 0 or gitsigns.changed ~= 0 or gitsigns.removed ~= 0 then
		return GIT_INFO_TYPE.changed
	end
	return GIT_INFO_TYPE.nochange
end

local function disable_barbar_keys()
	local barbar_keymaps = require("core.keymaps.barbar").keys
	for _, keymap in ipairs(barbar_keymaps) do
		vim.api.nvim_del_keymap(keymap.mode, keymap[1])
	end
end

local function enable_barbar_keys()
	local barbar_keymaps = require("core.keymaps.barbar").keys
	for _, keymap in ipairs(barbar_keymaps) do
		vim.api.nvim_set_keymap(keymap.mode, keymap[1], keymap[2], {
			silent = keymap.silent,
			noremap = keymap.noremap,
			desc = keymap.desc,
		})
	end
end

local function table_contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
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

_G.diffview_opened = false
local original_buffers = {}
local diffview_open_project = false

local M = {}

M.diffview_open_current = function()
	if _G.diffview_opened then
		return
	end
	local git_info = get_git_info()
	if git_info == GIT_INFO_TYPE.error then
		vim.notify("Gitsigns Error.", vim.log.levels.ERROR, { title = "Diffview" })
		return
	elseif git_info == GIT_INFO_TYPE.untraced then
		vim.notify("Untraced File.", vim.log.levels.WARN, { title = "Diffview" })
		return
	elseif git_info == GIT_INFO_TYPE.nochange then
		vim.notify("File Has No Change.", vim.log.levels.WARN, { title = "Diffview" })
		return
	end

	diffview_open_project = false
	vim.cmd("DiffviewOpen")
end

M.diffview_open_project = function()
	if _G.diffview_opened then
		return
	end
	diffview_open_project = true
	vim.cmd("DiffviewOpen")
end

M.diffview_open_history = function()
	if _G.diffview_opened then
		return
	end
	diffview_open_project = true
	vim.cmd("DiffviewFileHistory")
end

M.diffview_next_entry = function()
	if diffview_open_project then
		actions.select_next_entry()
	end
end

M.diffview_prev_entry = function()
	if diffview_open_project then
		actions.select_prev_entry()
	end
end

M.diffview_toggle_files = function()
	if diffview_open_project then
		actions.toggle_files()
	end
end

M.diffview_stage_hunk = function()
	if diffview_open_project then
		vim.cmd("Gitsigns stage_hunk")
	end
end

M.diffview_stage_buffer = function()
	if diffview_open_project then
		vim.cmd("Gitsigns stage_buffer")
	end
end

M.diffview_undo_stage_hunk = function()
	if diffview_open_project then
		vim.cmd("Gitsigns undo_stage_hunk")
	end
end

M.diffview_undo_stage_all = function()
	if diffview_open_project then
		actions.unstage_all()
	end
end

M.diffview_view_opened_hunk = function()
	_G.diffview_opened = true
	disable_barbar_keys()
	original_buffers = get_buffers()
	for _, buffer in ipairs(original_buffers) do
		vim.api.nvim_buf_set_option(buffer, "buflisted", false)
	end
	if not diffview_open_project then
		actions.toggle_files()
	end
end

M.diffview_view_close_hunk = function()
	_G.diffview_opened = false
	enable_barbar_keys()
	for _, buffer in ipairs(get_buffers()) do
		if not table_contains(original_buffers, buffer) then
			vim.api.nvim_buf_delete(buffer, { force = true })
		end
	end
	for _, buffer in ipairs(original_buffers) do
		vim.api.nvim_buf_set_option(buffer, "buflisted", true)
		vim.api.nvim_buf_set_option(buffer, "modifiable", true)
		vim.api.nvim_buf_call(buffer, function()
			vim.opt_local.rnu = true
			vim.opt_local.signcolumn = "yes"
		end)
	end
end

M.diffview_buffer_read_hunk = function(buffer)
	vim.api.nvim_buf_set_option(buffer, "modifiable", false)
	vim.opt_local.rnu = false
	vim.opt_local.signcolumn = "no"
	vim.cmd("normal !gg")
end

return M
