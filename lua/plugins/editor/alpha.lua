local M = {
	"goolord/alpha-nvim",
	lazy = false,
	priority = 8000,
}

M.init = function()
	PluginVars.insert(PluginVars.lualine_disabled_filetypes, "alpha")
end

M.opts = function()
	local dashboard = require("alpha.themes.dashboard")
	-- header
	dashboard.section.header.val = Config.dashboard_header
	dashboard.section.header.opts.hl = "Function"
	-- footer
	dashboard.section.footer.opts.hl = "Comment"
	-- button
	local buttons = {}
	for _, cfg in ipairs(Config.dashboard_buttons) do
		local button = dashboard.button(cfg.key, cfg.name, cfg.cmd)
		button.opts.hl = "Label"
		button.opts.hl_shortcut = "Comment"
		button.opts.width = 50
		table.insert(buttons, button)
	end
	dashboard.section.buttons.val = buttons
	-- layout
	dashboard.config.layout = {
		{ type = "padding", val = 2 },
		dashboard.section.header,
		{ type = "padding", val = 5 },
		dashboard.section.buttons,
		{ type = "padding", val = 1 },
		dashboard.section.footer,
	}
	return dashboard
end

M.config = function(_, dashboard)
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			local plugin_info = stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
			dashboard.section.footer.val = Config.dashboard_footer_name .. " | " .. plugin_info
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
	require("alpha").setup(dashboard.opts)
end

return M
