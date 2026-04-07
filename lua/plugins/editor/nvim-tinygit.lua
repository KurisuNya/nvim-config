M = {
	"chrisgrieser/nvim-tinygit",
	ft = { "gitrebase", "gitcommit" },
}

M.keys = function()
	vim.keymap.set("n", "<leader>gc", require("tinygit").smartCommit, {
		noremap = true,
		silent = true,
		desc = "Git Commit (Auto Add)",
	})
	vim.keymap.set("n", "<leader>gp", require("tinygit").push, {
		noremap = true,
		silent = true,
		desc = "Git Push",
	})
	vim.keymap.set("n", "<leader>gh", require("tinygit").fileHistory, {
		noremap = true,
		silent = true,
		desc = "Git History File",
	})
end

local border_style = Config.border_style
local fallback = Config.border_style_fallback
border_style = border_style == "none" and fallback or border_style
M.opts = {
	commit = { border = border_style },
	history = { diffPopup = { border = border_style } },
}
return M
