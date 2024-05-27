local M = {}
M.config = function()
	require("projections").setup({
		workspaces = _G.workspaces,
		sessions_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/projections_sessions"),
		store_hooks = {
			pre = function()
				if pcall(require, "neo-tree") then
					vim.cmd([[Neotree action=close]])
				end
			end,
		},
	})
	require("telescope").load_extension("projections")

	local Session = require("projections.session")
	vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
		callback = function()
			Session.store(vim.loop.cwd())
		end,
	})
	local switcher = require("projections.switcher")
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			if vim.fn.argc() == 0 then
				switcher.switch(vim.loop.cwd())
			end
		end,
	})
	vim.opt.sessionoptions:append("localoptions")
	vim.opt.sessionoptions:append("globals")
end
return M
