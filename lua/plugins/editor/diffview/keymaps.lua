local M = {}

M.keys = function()
	vim.keymap.set("n", "<leader>gD", "<Cmd>DiffviewOpen<CR>", {
		silent = true,
		noremap = true,
		desc = "Git Diff Project",
	})

	vim.keymap.set("n", "<leader>gH", "<Cmd>DiffviewFileHistory<CR>", {
		silent = true,
		noremap = true,
		desc = "Git History Project",
	})
end

M.view_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		{ "n", "g?", actions.help("view"), { desc = "? Open Help Panel" } },
		{ "n", "<leader>q", actions.close, { desc = "Close Diffview" } },
		{ "n", "<leader>e", actions.toggle_files, { desc = "Files Toggle" } },
		{ "n", "<tab>", actions.select_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", actions.select_prev_entry, { desc = "File Diff Open Previous" } },
	}
	return list
end

M.file_panel_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		-- help panel
		{ "n", "g?", actions.help("file_panel"), { desc = "? Open Help Panel" } },
		-- basic
		{ "n", "<leader>q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
		{ "n", "j", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "k", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<down>", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "<up>", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<c-u>", actions.scroll_view(-0.25), { desc = "View Scroll Up" } },
		{ "n", "<c-d>", actions.scroll_view(0.25), { desc = "View Scroll Down" } },
		{ "n", "<CR>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "R", actions.refresh_files, { desc = "Files Refresh" } },
		{ "n", "<leader>e", actions.toggle_files, { desc = "Files Toggle" } },
		{ "n", "<tab>", actions.select_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", actions.select_prev_entry, { desc = "File Diff Open Previous" } },
		-- fold
		{ "n", "zo", actions.open_fold, { desc = "Fold Expand" } },
		{ "n", "zc", actions.close_fold, { desc = "Fold Collapse" } },
		{ "n", "za", actions.toggle_fold, { desc = "Fold Toggle " } },
		{ "n", "zR", actions.open_all_folds, { desc = "Fold Expand All" } },
		{ "n", "zM", actions.close_all_folds, { desc = "Fold Collapse All" } },
		-- git actions
		{ "n", "s", actions.toggle_stage_entry, { desc = "Git Toggle Staged" } },
		{ "n", "S", actions.stage_all, { desc = "Git Stage All" } },
		{ "n", "U", actions.unstage_all, { desc = "Git Unstage All" } },
		{ "n", "L", actions.open_commit_log, { desc = "Git Commit Log" } },
	}
	return list
end

M.file_history_panel_keymap_list = function()
	local actions = require("diffview.actions")
	local list = {
		-- panel
		{ "n", "g?", actions.help("file_panel"), { desc = "? Open Help Panel" } },
		{ "n", "g!", actions.options, { desc = "Open Option Panel" } },
		--basic
		{ "n", "<leader>q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
		{ "n", "j", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "k", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<down>", actions.next_entry, { desc = "File Entry Next" } },
		{ "n", "<up>", actions.prev_entry, { desc = "File Entry Previous" } },
		{ "n", "<c-u>", actions.scroll_view(-0.25), { desc = "View Scroll Up" } },
		{ "n", "<c-d>", actions.scroll_view(0.25), { desc = "View Scroll Down" } },
		{ "n", "<CR>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "File Open Selected" } },
		{ "n", "<leader>e", actions.toggle_files, { desc = "Files Toggle" } },
		{ "n", "<tab>", actions.select_next_entry, { desc = "File Diff Open Next" } },
		{ "n", "<s-tab>", actions.select_prev_entry, { desc = "File Diff Open Previous" } },
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
		{ "n", "g?", actions.help("option_panel"), { desc = "? Open Help Panel" } },
		{ "n", "<CR>", actions.select_entry, { desc = "Change Current Option" } },
		{ "n", "q", actions.close, { desc = "Close Option Panel" } },
		{ "n", "<esc>", actions.close, { desc = "Close Option Panel" } },
	}
	return list
end

return M
