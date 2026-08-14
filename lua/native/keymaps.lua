local keymap = vim.keymap
local norm_opts = { silent = true }
local expr_opts = { silent = true, expr = true }
local add_desc = function(opts, desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

vim.g.mapleader = " " -- Leader key
vim.g.maplocalleader = "," -- Local leader key
Utils.unset_default_keys({ "n", "x" }, { "q", "Q", "m", "H", "M", "L" })

-- move
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "x" }, "J", "5gj", norm_opts)
keymap.set({ "n", "x" }, "K", "5gk", norm_opts)

-- search

---@param direction string
---| "forward"
---| "backward"
local in_place_search = function(direction)
  local pattern
  local mode = vim.fn.mode()
  if mode:match("[vV\22]") then
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local region = vim.fn.getregion(start_pos, end_pos, { type = mode })
    local escaped = vim.tbl_map(function(line)
      return vim.fn.escape(line, "/\\")
    end, region)
    pattern = "\\V" .. table.concat(escaped, "\\n")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  else
    local word = vim.fn.expand("<cword>")
    if word == "" then
      return
    end
    pattern = "\\<" .. vim.fn.escape(word, "/\\") .. "\\>"
  end

  vim.fn.setreg("/", pattern)
  vim.v.hlsearch = true
  vim.v.searchforward = direction == "forward" and 1 or 0
  vim.fn.search(pattern, "ce")
  vim.fn.search(pattern, "cb")
end

vim.keymap.set({ "n", "x" }, "#", function()
  in_place_search("backward")
end, norm_opts)
vim.keymap.set({ "n", "x" }, "*", function()
  in_place_search("forward")
end, norm_opts)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- save and quit
keymap.set("n", "<leader>w", "<CMD>w<CR>", add_desc(norm_opts, "Save"))
keymap.set("n", "<leader>q", "<CMD>q<CR>", add_desc(norm_opts, "Quit"))

-- macro
keymap.set("n", "<leader>M", "q", add_desc(norm_opts, "Macro Record"))

-- join lines
keymap.set({ "n", "x" }, "<leader>j", "J", add_desc(norm_opts, "Join Lines"))

-- add and sub
keymap.set({ "n", "x" }, "+", "<C-a>", add_desc(norm_opts, "Add"))
keymap.set({ "n", "x" }, "-", "<C-x>", add_desc(norm_opts, "Subtract"))
keymap.set({ "n", "x" }, "g+", "g<C-a>", add_desc(norm_opts, "Add (multiple)"))
keymap.set({ "n", "x" }, "g-", "g<C-x>", add_desc(norm_opts, "Subtract (multiple)"))

-- indent
keymap.set("x", "<", "<gv", norm_opts)
keymap.set("x", ">", ">gv", norm_opts)

-- normal mode commands
keymap.set("x", "<leader>n", ":normal ")

-- diagnostics
keymap.set("n", "<leader>x", vim.diagnostic.setqflist, add_desc(norm_opts, "Show Diagnostics"))

-- diff
keymap.set("n", "<leader>dd", function()
  if vim.api.nvim_get_option_value("diff", {}) then
    vim.cmd("windo diffoff")
  else
    vim.cmd("windo diffthis")
  end
end, add_desc(norm_opts, "Diff Toggle"))

-- split
local split_win = function(split)
  return function()
    vim.api.nvim_open_win(0, true, { split = split })
  end
end

keymap.set("n", "<leader><Right>", split_win("right"), add_desc(norm_opts, "Vertical Split (Right)"))
keymap.set("n", "<leader><Left>", split_win("left"), add_desc(norm_opts, "Vertical Split (Left)"))
keymap.set("n", "<leader><Down>", split_win("below"), add_desc(norm_opts, "Horizontal Split (Below)"))
keymap.set("n", "<leader><Up>", split_win("above"), add_desc(norm_opts, "Horizontal Split (Above)"))
keymap.set("n", "<C-Left>", "<C-w>h", norm_opts)
keymap.set("n", "<C-Down>", "<C-w>j", norm_opts)
keymap.set("n", "<C-Up>", "<C-w>k", norm_opts)
keymap.set("n", "<C-Right>", "<C-w>l", norm_opts)

keymap.set("t", "<C-'>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
