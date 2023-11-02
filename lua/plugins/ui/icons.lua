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

return M
