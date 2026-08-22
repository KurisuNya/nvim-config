_G.Icons = {}

local nerd = Config.use_nerd_font

-- ┌──────────────┐
-- │ native icons │
-- └──────────────┘

Icons.borderchars = {
  bold = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
  double = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
  none = { "", "", "", "", "", "", "", "" },
  rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  solid = { " ", " ", " ", " ", " ", " ", " ", " " },
}

Icons.fillchars = {
  fold = " ",
  foldopen = nerd and "" or "▾",
  foldclose = nerd and "" or "▸",
  foldsep = " ",
  foldinner = " ",
  diff = "╱",
  eob = " ",
}

Icons.listchars = {
  tab = "··»",
  trail = "·",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}

Icons.diagnostic = {
  hint = nerd and "" or "✦",
  info = nerd and "" or "ℹ",
  warning = nerd and "" or "⚠",
  error = nerd and "" or "✖",
}

-- ┌──────────────┐
-- │ plugin icons │
-- └──────────────┘

Icons.git = {
  added = "✚",
  deleted = nerd and "" or "✖",
  modified = nerd and "●" or "✎",
  renamed = nerd and "" or "→",
  untracked = nerd and "󰞋" or "?",
  ignored = nerd and "" or "·",
  unstaged = nerd and "" or "○",
  staged = nerd and "" or "●",
  conflict = nerd and "" or "×",
  branch = nerd and "" or "λ",
}

Icons.log_levels = {
  error = nerd and "" or "✖",
  warn = nerd and "" or "⚠",
  info = nerd and "" or "ℹ",
  debug = nerd and "" or "D",
  trace = nerd and "" or "T",
}

Icons.misc = {
  lsp = nerd and "" or "ℒ",
  dap = nerd and "" or "▶",
  pinned = nerd and "" or "*",
  indicator = nerd and "" or "»",
}

Icons.dap = {
  BreakPoint = "●",
  BreakPointCondition = nerd and "" or "◉",
  BreakPointRejected = nerd and "" or "✖",
  LogPoint = nerd and "" or "◆",
  Stopped = nerd and "" or "▶",
  Terminate = nerd and "" or "■",
  Pause = nerd and "" or "⏸",
  Play = nerd and "" or "▶",
  RunLast = "↻",
  StepBack = nerd and "" or "←",
  StepInto = nerd and "󰆹" or "↓",
  StepOut = nerd and "󰆸" or "↑",
  StepOver = nerd and "" or "→",
}
