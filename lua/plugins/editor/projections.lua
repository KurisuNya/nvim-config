local M = {
	"gnikdroy/projections.nvim",
	branch = "pre_release",
	event = "VeryLazy",
}

PluginVars.projections_close_filetypes = { "help", "qf", "gitcommit", "gitrebase", "netrw" }

M.init = function()
	vim.opt.sessionoptions:append("globals")
end

M.keys = function()
	if Utils.plugin_exists("telescope.nvim") then
		vim.keymap.set(
			"n",
			"<leader>fp",
			"<CMD>Telescope projections<CR>",
			{ desc = "find project", noremap = true, silent = true }
		)
	end
end

M.config = function()
	local loop = (vim.uv or vim.loop)
	require("projections").setup({
		workspaces = Config.workspaces,
		sessions_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/projections_sessions"),
		store_hooks = {
			pre = function()
				local buffers = vim.fn.getbufinfo()
				for _, buffer in ipairs(buffers) do
					local filetype = vim.fn.getbufvar(buffer.bufnr, "&filetype")
					if vim.tbl_contains(PluginVars.projections_close_filetypes, filetype) then
						vim.fn.bdelete(buffer.bufnr)
					end
				end
			end,
		},
	})
	if Utils.plugin_exists("telescope.nvim") then
		require("telescope").load_extension("projections")
	end
	local Session = require("projections.session")
	vim.api.nvim_create_user_command("ProjectionsLastSession", function()
		Session.restore_latest()
	end, {})
	vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
		group = Utils.create_augroup("store_session"),
		callback = function()
			Session.store(loop.cwd())
		end,
	})
end
return M
