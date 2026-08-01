local M = {
	"folke/snacks.nvim",
	lazy = false,
	priority = 9000,
}

M.opts = function()
	local opts = {
		dashboard = {
			enabled = true,
			preset = { header = Config.dashboard_header },
		},
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

	local dashboard_keys = {}
	for _, cfg in ipairs(Config.dashboard_buttons) do
		table.insert(dashboard_keys, {
			text = {
				{ cfg.name, hl = "special", width = 45 },
				{ cfg.key, hl = "comment" },
			},
			action = cfg.cmd,
			key = cfg.key,
			align = "center",
		})
	end
	opts.dashboard.preset.keys = dashboard_keys

	opts.dashboard.sections = {
		{ section = "header", padding = 4 },
		{ section = "keys", gap = 1, padding = 2 },
		function()
			M.lazy_stats = M.lazy_stats and M.lazy_stats.startuptime > 0 and M.lazy_stats
				or require("lazy.stats").stats()
			local ms = (math.floor(M.lazy_stats.startuptime * 100 + 0.5) / 100)
			return {
				align = "center",
				text = {
					{ Config.dashboard_footer_name .. " | ", hl = "comment" },
					{ M.lazy_stats.loaded .. "/" .. M.lazy_stats.count .. " plugins ", hl = "comment" },
					{ "in " .. ms .. "ms", hl = "comment" },
				},
			}
		end,
	}
	return opts
end

M.init = function()
	PluginVars.insert(PluginVars.lualine_disabled_filetypes, "snacks_dashboard")

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
