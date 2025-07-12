local M = {
	"MagicDuck/grug-far.nvim",
	init = function()
		PluginVars.insert(PluginVars.projections_close_filetypes, "grug-far")
	end,
	event = "VeryLazy",
}

M.keys = {
	{
		"<leader>R",
		function()
			local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
			require("grug-far").open({
				transient = true,
				prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
			})
		end,
		mode = { "n", "v" },
		desc = "Search and Replace",
	},
}
local keymaps = {
	close = { n = "q" },
	replace = { n = "<leader>w" },
	syncLine = { v = "<leader>w" },
	qflist = { n = "<leader>sq" },
	historyOpen = { n = "<leader>h" },
	refresh = { n = "<leader>r" },
	openNextLocation = { n = "<down>" },
	openPrevLocation = { n = "<up>" },
	gotoLocation = { n = "<enter>" },
	pickHistoryEntry = { n = "<enter>" },
	help = { n = "?" },
}

M.config = function()
	require("grug-far").setup({ keymaps = keymaps })
end
return M
