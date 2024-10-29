---@diagnostic disable: param-type-mismatch
local M = {}
M.init = function()
	vim.opt.sessionoptions:append("globals")
end
M.config = function()
	local loop = (vim.uv or vim.loop)
	require("projections").setup({
		workspaces = KurisuNya.config.workspaces,
		sessions_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/projections_sessions"),
		store_hooks = {
			pre = function()
				local buffers = vim.fn.getbufinfo()
				local close_filetypes = KurisuNya.config.close_before_session_filetypes
				for _, buffer in ipairs(buffers) do
					local filetype = vim.fn.getbufvar(buffer.bufnr, "&filetype")
					if vim.tbl_contains(close_filetypes, filetype) then
						vim.fn.bdelete(buffer.bufnr)
					end
				end
			end,
		},
	})
	if KurisuNya.utils.plugin_exist("telescope.nvim") then
		require("telescope").load_extension("projections")
	end
	local Session = require("projections.session")
	vim.api.nvim_create_user_command("ProjectionsLastSession", function()
		if vim.fn.argc() ~= 0 then
			return
		end
		local session_info = Session.info(loop.cwd())
		if session_info == nil then
			Session.restore_latest()
		else
			Session.restore(loop.cwd())
		end
	end, {})
	vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
		callback = function()
			Session.store(loop.cwd())
		end,
	})
	local switcher = require("projections.switcher")
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			if vim.fn.argc() == 0 then
				switcher.switch(loop.cwd())
			end
		end,
	})
end
return M
