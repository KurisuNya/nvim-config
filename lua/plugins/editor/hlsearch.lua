return {
	"KurisuNya/hlsearch.nvim",
	event = "VeryLazy",
	opts = {},
	keys = function()
		local hlsearch = require("hlsearch")
		vim.keymap.set({ "n", "x" }, "<C-l>", function()
			local enabled = hlsearch.is_enabled()
			hlsearch.set_enabled(not enabled)
			vim.notify(
				(enabled and "hlsearch disabled" or "hlsearch enabled"),
				vim.log.levels.INFO,
				{ title = "hlsearch.nvim" }
			)
		end, { silent = true, desc = "Toggle hlsearch" })
	end,
}
