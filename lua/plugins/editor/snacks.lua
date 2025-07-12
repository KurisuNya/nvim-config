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
