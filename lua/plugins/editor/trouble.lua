local M = {
	"folke/trouble.nvim",
	init = function()
		PluginVars.insert(PluginVars.projections_close_filetypes, "trouble")
	end,
	opts = {},
	event = "VeryLazy",
}

M.keys = {
	{
		"<leader>x",
		"<CMD>Trouble diagnostics toggle<CR>",
		desc = "Trouble Diagnostic",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"[x",
		function()
			if require("trouble").is_open() then
				require("trouble").prev({ skip_groups = true, jump = true })
			else
				vim.notify("Trouble is not open", vim.log.levels.WARN)
			end
		end,
		desc = "Previous Trouble Item",
	},
	{
		"]x",
		function()
			if require("trouble").is_open() then
				require("trouble").next({ skip_groups = true, jump = true })
			else
				vim.notify("Trouble is not open", vim.log.levels.WARN)
			end
		end,
		desc = "Next Trouble Item",
	},
}
return M
