local M = {
	-- key mappings
	require("plugins.editor.which-key"),
	-- dashboard
	require("plugins.editor.alpha"),
	-- bars and lines
	require("plugins.editor.barbar"),
	require("plugins.editor.lualine"),
	-- file explorer
	require("plugins.editor.neo-tree"),
	-- fuzzy finder
	require("plugins.editor.telescope"),
	-- project management
	require("plugins.editor.projections"),
	-- terminal
	require("plugins.editor.toggleterm"),
	-- find and replace
	require("plugins.editor.grug-far"),
	-- quickfix
	require("plugins.editor.trouble"),
	require("plugins.editor.quicker"),
	-- git
	require("plugins.editor.gitsigns"),
	require("plugins.editor.nvim-tinygit"),
	require("plugins.editor.diffview"),
	require("plugins.editor.git-conflict"),
	-- better ui
	require("plugins.editor.dressing"),
	require("plugins.editor.noice"),
	require("plugins.editor.virt-column"),
	-- misc
	require("plugins.editor.sniprun"),
	require("plugins.editor.icon-picker"),
	require("plugins.editor.snacks"),
	require("plugins.editor.numb"),
	require("plugins.editor.hlsearch"),
	require("plugins.editor.stickybuf"),
}

local linux = {
	require("plugins.editor.fcitx"),
	require("plugins.editor.suda"),
}

if Utils.is_linux() then
	M = vim.list_extend(M, linux)
end

return M
