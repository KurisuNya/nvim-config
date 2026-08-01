local M = {
	"chrisgrieser/nvim-tinygit",
	ft = { "gitrebase", "gitcommit" },
}

M.keys = {
	{
		"<leader>gc",
		function()
			require("tinygit").smartCommit()
		end,
		silent = true,
		desc = "Git Commit (Auto Add)",
	},
	{
		"<leader>gp",
		function()
			require("tinygit").push()
		end,
		silent = true,
		desc = "Git Push",
	},
	{
		"<leader>gh",
		function()
			require("tinygit").fileHistory()
		end,
		silent = true,
		desc = "Git History File",
	},
}

local border_style = Config.border_style
local fallback = Config.border_style_fallback
border_style = border_style == "none" and fallback or border_style
M.opts = {
	commit = { border = border_style },
	history = { diffPopup = { border = border_style } },
}
return M
