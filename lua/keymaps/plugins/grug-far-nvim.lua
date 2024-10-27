local M = {}
M.keys = {
	{
		"<leader>R",
		function()
			local grug = require("grug-far")
			local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
			grug.open({
				transient = true,
				prefills = {
					filesFilter = ext and ext ~= "" and "*." .. ext or nil,
				},
			})
		end,
		mode = { "n", "v" },
		desc = "Search and Replace",
	},
}
M.keymaps = {
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
return M
