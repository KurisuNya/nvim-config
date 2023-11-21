local M = {}
M.keys = function()
	local custom = require("plugins.tool.diffview_custom")
	vim.keymap.set("n", "<leader>gP", custom.diffview_open_project, {
		silent = true,
		noremap = true,
		desc = "Git Project Diff",
	})

	vim.keymap.set("n", "<leader>gp", custom.diffview_open_current, {
		silent = true,
		noremap = true,
		desc = "Git File Diff",
	})

	vim.keymap.set("n", "<leader>gH", custom.diffview_open_history, {
		silent = true,
		noremap = true,
		desc = "Git Project History",
	})
end

M.view_keymap_list = function()
	local custom = require("plugins.tool.diffview_custom")
	local actions = require("diffview.actions")
	local list = {
		{ "n", "<leader>e", custom.diffview_toggle_files, { desc = "Files Toggle " } },
		{ "n", "<tab>", custom.diffview_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", custom.diffview_prev_entry, { desc = "File Diff Open Previous" } },
		{ "n", "s", custom.diffview_stage_hunk, { desc = "Git Toggle Staged" } },
		{ "n", "S", custom.diffview_stage_buffer, { desc = "Git Toggle Staged" } },
		{ "n", "u", custom.diffview_undo_stage_hunk, { desc = "Git Unstage All" } },
		{ "n", "U", custom.diffview_undo_stage_all, { desc = "Git Unstage All" } },
		{ "n", "<leader>q", actions.close, { desc = "Close Diffview" } },
		{ "n", "[x", actions.prev_conflict, { desc = "Conflict Previous" } },
		{ "n", "]x", actions.next_conflict, { desc = "Conflict Next" } },
		{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Conflict Choose Ours" } },
		{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Conflict Choose Theirs" } },
		{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Conflict Choose Base" } },
		{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Conflict Choose All" } },
		{ "n", "<leader>cd", actions.conflict_choose("none"), { desc = "Conflict Delete Region" } },
		{
			"n",
			"<leader>cO",
			actions.conflict_choose_all("ours"),
			{ desc = "Conflict Choose Ours Whole File" },
		},
		{
			"n",
			"<leader>cT",
			actions.conflict_choose_all("theirs"),
			{ desc = "Conflict Choose Theirs Whole File" },
		},
		{
			"n",
			"<leader>cB",
			actions.conflict_choose_all("base"),
			{ desc = "Conflict Choose Base Whole File" },
		},
		{
			"n",
			"<leader>cA",
			actions.conflict_choose_all("all"),
			{ desc = "Conflict Choose All Whole File" },
		},
		{
			"n",
			"<leader>cD",
			actions.conflict_choose_all("none"),
			{ desc = "Conflict Delete Region Whole File" },
		},
	}
	return list
end

M.file_panel_keymap_list = function()
	local custom = require("plugins.tool.diffview_custom")
	local actions = require("diffview.actions")
	local list = {
		-- help panel
		{ "n", "g?", actions.help("file_panel"), { desc = "Open Help Panel" } },
		-- basic
		{
			"n",
			"<leader>q",
			function()
				vim.cmd("DiffviewClose")
			end,
			{ desc = "Close Diffview" },
		},
		{ "n", "j", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "k", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<down>", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "<up>", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<c-u>", actions.scroll_view(-0.25), { desc = "View Scroll Up" } },
		{ "n", "<c-d>", actions.scroll_view(0.25), { desc = "View Scroll Down" } },
		{ "n", "<cr>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "R", actions.refresh_files, { desc = "Files Refresh" } },
		{ "n", "<leader>e", custom.diffview_toggle_files, { desc = "Files Toggle" } },
		{ "n", "<tab>", custom.diffview_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", custom.diffview_prev_entry, { desc = "File Diff Open Previous" } },
		-- fold
		{ "n", "zo", actions.open_fold, { desc = "Fold Expand" } },
		{ "n", "zc", actions.close_fold, { desc = "Fold Collapse" } },
		{ "n", "za", actions.toggle_fold, { desc = "Fold Toggle " } },
		{ "n", "zR", actions.open_all_folds, { desc = "Fold Expand All" } },
		{ "n", "zM", actions.close_all_folds, { desc = "Fold Collapse All" } },
		-- git actions
		{ "n", "S", actions.toggle_stage_entry, { desc = "Git Toggle Staged" } },
		{ "n", "SS", actions.stage_all, { desc = "Git Stage All" } },
		{ "n", "U", actions.unstage_all, { desc = "Git Unstage All" } },
		{ "n", "L", actions.open_commit_log, { desc = "Git Commit Log" } },
		{ "n", "[x", actions.prev_conflict, { desc = "Conflict Previous" } },
		{ "n", "]x", actions.next_conflict, { desc = "Conflict Next" } },
		{
			"n",
			"<leader>cO",
			actions.conflict_choose_all("ours"),
			{ desc = "Conflict Choose Ours Whole File" },
		},
		{
			"n",
			"<leader>cT",
			actions.conflict_choose_all("theirs"),
			{ desc = "Conflict Choose Theirs Whole File" },
		},
		{
			"n",
			"<leader>cB",
			actions.conflict_choose_all("base"),
			{ desc = "Conflict Choose Base Whole File" },
		},
		{
			"n",
			"<leader>cA",
			actions.conflict_choose_all("all"),
			{ desc = "Conflict Choose All Whole File" },
		},
		{
			"n",
			"<leader>cD",
			actions.conflict_choose_all("none"),
			{ desc = "Conflict Delete Region Whole File" },
		},
	}
	return list
end

M.file_history_panel_keymap_list = function()
	local custom = require("plugins.tool.diffview_custom")
	local actions = require("diffview.actions")
	local list = {
		-- panel
		{ "n", "g?", actions.help("file_panel"), { desc = "Open Help Panel" } },
		{ "n", "g!", actions.options, { desc = "Open Option Panel" } },
		--basic
		{
			"n",
			"<leader>q",
			function()
				vim.cmd("DiffviewClose")
			end,
			{ desc = "Close Diffview" },
		},
		{ "n", "j", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "k", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<down>", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "<up>", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<c-u>", actions.scroll_view(-0.25), { desc = "View Scroll Up" } },
		{ "n", "<c-d>", actions.scroll_view(0.25), { desc = "View Scroll Down" } },
		{ "n", "<cr>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<leader>e", custom.diffview_toggle_files, { desc = "Files Toggle" } },
		{ "n", "<tab>", custom.diffview_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", custom.diffview_prev_entry, { desc = "File Diff Open Previous" } },
		--fold
		{ "n", "zo", actions.open_fold, { desc = "Fold Expand" } },
		{ "n", "zc", actions.close_fold, { desc = "Fold Collapse" } },
		{ "n", "za", actions.toggle_fold, { desc = "Fold Toggle " } },
		{ "n", "zR", actions.open_all_folds, { desc = "Fold Expand All" } },
		{ "n", "zM", actions.close_all_folds, { desc = "Fold Collapse All" } },
		-- git actions
		{ "n", "Y", actions.copy_hash, { desc = "Copy Commit Hash" } },
		{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
	}
	return list
end

M.diff3_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		{
			{ "n", "x" },
			"<leader>lo",
			actions.diffget("ours"),
			{ desc = "Load Ours Diff Hunk Of The File" },
		},
		{
			{ "n", "x" },
			"<leader>lt",
			actions.diffget("theirs"),
			{ desc = "Load Theirs Diff Hunk Of The File" },
		},
		{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open Help Panel" } },
	}
	return list
end

M.help_panel_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		{ "n", "q", actions.close, { desc = "Close Help Menu" } },
		{ "n", "<esc>", actions.close, { desc = "Close Help Menu" } },
	}
	return list
end

M.option_panel_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		{ "n", "g?", actions.help("option_panel"), { desc = "Open Help Panel" } },
		{ "n", "<tab>", actions.select_entry, { desc = "Change Current Option" } },
		{ "n", "<cr>", actions.select_entry, { desc = "Change Current Option" } },
		{ "n", "q", actions.close, { desc = "Close Option Panel" } },
		{ "n", "<esc>", actions.close, { desc = "Close Option Panel" } },
	}
	return list
end

return M
