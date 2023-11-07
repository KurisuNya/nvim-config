local M = {}
M.symbols = {
	Class = "󰠱",
	Color = "󰏘",
	Constant = "󰏿",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "󰇽",
	Fragment = "",
	Component = "",
	Function = "󰊕",
	Interface = "",
	Implementation = "",
	Keyword = "󰌋",
	Method = "󰆧",
	Module = "",
	Namespace = "󰌗",
	Operator = "󰆕",
	Package = "",
	Property = "󰜢",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "󰉿",
	TypeParameter = "󰅲",
	Undefined = "",
	Unit = "",
	Value = "󰎠",
	Variable = "",
	-- ccls-specific icons.
	TypeAlias = "",
	Parameter = "",
	StaticMethod = "",
	Macro = "",
	Array = "󰅪",
	Boolean = "",
	Null = "󰟢",
	Number = "",
	Object = "󰅩",
	String = "󰉿",
	Default = "",
	File = "",
	Files = "",
	Folder = "󰉋",
	FileTree = "󰙅",
	Import = "",
	Symlink = "",
}

M.diagnostics = {
	Hint = "",
	Info = "",
	Warning = "",
	Error = "",
}

M.git = {
	Head = "",
	Modified = "●",
	Unstaged = "",
	Staged = "",
	Conflict = "שׂ",
	Renamed = "",
	Untracked = "ﲉ",
	Deleted = "",
	Ignored = "",
}

M.dap = {
	BreakPoint = "",
	BreakPointCondition = "ﳁ",
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

M.ui = {
	ArrowClose = "",
	ArrowOpen = "",
	Indicator = "",
}

return M
