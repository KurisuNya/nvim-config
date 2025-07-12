local M = {}

M.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
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

M.symbols = {
	-- kind
	Break = "󰙧",
	Call = "󰃷",
	Case = "󰬶",
	Class = "󰠱",
	Color = "󰏘",
	Constant = "󰏿",
	Constructor = "",
	Continue = "󰞘",
	Declaration = "󰙠",
	Delete = "󱟁",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "󰇽",
	File = "󰈙",
	Folder = "󰉋",
	Fragment = "",
	Function = "󰊕",
	Implementation = "",
	Interface = "",
	Keyword = "󰌋",
	List = "󰅪",
	Loop = "󰑖",
	Method = "󰆧",
	Module = "",
	Namespace = "󰌗",
	Operator = "󰆕",
	Package = "",
	Property = "󰜢",
	Reference = "",
	Regex = "",
	Snippet = "",
	Statement = "󰅩",
	Struct = "",
	Switch = "",
	Text = "󰉿",
	TypeParameter = "󰅲",
	Undefined = "",
	Unit = "",
	Value = "󰎠",
	Variable = "",
	-- ccls-specific icons
	Macro = "",
	Parameter = "",
	StaticMethod = "",
	Terminal = "",
	TypeAlias = "",
	-- type
	Array = "󰅪",
	Boolean = "",
	Null = "󰟢",
	Number = "",
	Object = "󰅩",
	String = "󰉿",
	--document
	Default = "",
	Files = "",
	FileFind = "󰈞",
	FileTree = "󰙅",
	Import = "",
	Symlink = "",
	Word = "",
}

M.cmp = {
	Copilot = "",
	buffer = "",
	latex_symbols = "",
	luasnip = "󰃐",
	nvim_lsp = "",
	nvim_lua = "",
	orgmode = "",
	path = "",
	aysc_path = "",
	spell = "󰓆",
	tmux = "",
	treesitter = "",
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
