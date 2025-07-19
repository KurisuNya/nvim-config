local M = {
	"folke/snacks.nvim",
	lazy = false,
	priority = 9000,
}

M.opts = {
	quickfile = { enabled = true },
	bigfile = { enabled = true },
	notifier = {
		enabled = true,
		icons = Icons.log_levels,
		width = { min = 30, max = 0.4 },
	},
	styles = {
		notification = {
			border = Config.border_style,
			wo = { wrap = true },
		},
	},
}

M.init = function()
	local notifs = {}
	local function temp(...)
		table.insert(notifs, vim.F.pack_len(...))
	end

	local orig = vim.notify
	vim.notify = temp

	local timer = vim.uv.new_timer()
	local check = assert(vim.uv.new_check())

	local replay = function()
		timer:stop()
		check:stop()
		if vim.notify == temp then
			vim.notify = orig -- put back the original notify if needed
		end
		vim.schedule(function()
			---@diagnostic disable-next-line: no-unknown
			for _, notif in ipairs(notifs) do
				vim.notify(vim.F.unpack_len(notif))
			end
		end)
	end

	-- wait till vim.notify has been replaced
	check:start(function()
		if vim.notify ~= temp then
			replay()
		end
	end)
	-- or if it took more than 500ms, then something went wrong
	timer:start(500, 0, replay)
end

M.config = function(_, opts)
	local notify = vim.notify
	require("snacks").setup(opts)
	vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
	-- HACK: restore vim.notify after snacks setup and let noice.nvim take over
	-- this is needed to have early notifications show up in noice history
	if Utils.plugin_exists("noice.nvim") then
		vim.notify = notify
	end
end

return M
