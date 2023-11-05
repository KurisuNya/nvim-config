local M = {}

M.diagnostics = {
	icons = {
		hint = "",
		info = "",
		warning = "",
		error = "",
	},
}

M.git = {
	head = "",
	modified = "●",
	unstaged = "",
	staged = "",
	conflict = "שׂ",
	renamed = "",
	untracked = "ﲉ",
	deleted = "",
	ignored = "",
}

M.dap = {
	break_point = "",
	break_point_condition = "ﳁ",
	break_point_rejected = "",
	log_point = "",
	stopped = "",
	terminate = "󰝤",
	pause = "",
	play = "",
	run_last = "↻",
	step_back = "",
	step_into = "󰆹",
	step_out = "󰆸",
	step_over = "󰆷",
}

M.ui = {
	arrow_close = "",
	arrow_open = "",
	indicator = "",
}

return M
