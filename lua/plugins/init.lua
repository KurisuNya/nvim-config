local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local repo_url = "https://github.com/KurisuNya/lazy.nvim.git"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
	local out = vim.fn.system({ "git", "clone", repo_url, lazy_path })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazy_path)

_G.PluginVars = {}

PluginVars.insert = function(tbl, item)
	if type(tbl) == "table" and not vim.tbl_contains(tbl, item) then
		table.insert(tbl, item)
	end
end

-- q to close
PluginVars.q_close_filetypes = { "help", "qf", "checkhealth" }
Utils.on_very_lazy(function()
	vim.api.nvim_create_autocmd("FileType", {
		group = Utils.create_augroup("close_with_q"),
		pattern = PluginVars.q_close_filetypes,
		callback = function(event)
			vim.bo[event.buf].buflisted = false
			vim.schedule(function()
				vim.keymap.set("n", "q", function()
					vim.cmd("close")
					pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
				end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
			end)
		end,
	})
end)

-- auto wrap
PluginVars.wrap_spell_filetypes = { "gitcommit", "txt" }
Utils.on_very_lazy(function()
	vim.api.nvim_create_autocmd("FileType", {
		group = Utils.create_augroup("wrap_spell"),
		pattern = PluginVars.wrap_spell_filetypes,
		callback = function()
			vim.opt_local.wrap = true
		end,
	})
end)

require("lazy").setup({
	require("plugins.colorscheme"),
	require("plugins.editor"),
	require("plugins.coding"),
	require("plugins.language"),
}, {
	defaults = { lazy = true },
	ui = {
		border = Config.border_style,
		view = {
			keys = { hover = "H" },
			commands = { home = { key = "Z" } },
		},
	},
	performance = {
		rtp = { disabled_plugins = {
			"gzip",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		} },
	},
})
