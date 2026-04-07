local M = {}

M.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	foldinner = " ",
	diff = "╱",
	eob = " ",
}

M.git = {
	Modified = "●",
	Unstaged = "",
	Staged = "",
	Conflict = "",
	Renamed = "",
	Untracked = "󰞋",
	Deleted = "",
	Ignored = "",
}

M.diagnostics = {
	Hint = "",
	Info = "",
	Warning = "",
	Error = "",
}

M.log_levels = {
	error = "",
	warn = "",
	info = "",
	debug = "",
	trace = "",
}

M.ui = {
	ArrowClose = "",
	ArrowOpen = "",
	Indicator = "",
	pinned = "",
}

M.dap = {
	BreakPoint = "󰝥",
	BreakPointCondition = "󰟃",
	BreakPointRejected = "",
	LogPoint = "",
	Stopped = "",
	Terminate = "󰝤",
	Pause = "",
	Play = "",
	RunLast = "↻",
	StepBack = "",
	StepInto = "󰆹",
	StepOut = "󰆸",
	StepOver = "󰆷",
}

return M
