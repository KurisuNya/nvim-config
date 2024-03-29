local M = {}
M.keys = {
	{
		"<leader>x",
		"<Cmd>Trouble diagnostics toggle<CR>",
		desc = "Trouble Diagnostic",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"[q",
		function()
			if require("trouble").is_open() then
				require("trouble").prev({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cprev)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Previous trouble/quickfix item",
	},
	{
		"]q",
		function()
			if require("trouble").is_open() then
				require("trouble").next({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cnext)
				if not ok then
					---@diagnostic disable-next-line: param-type-mismatch
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Next trouble/quickfix item",
	},
}
return M
