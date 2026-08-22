vim.g.mapleader = " "
vim.g.maplocalleader = ","
Utils.keymap.unset({ "n", "x" }, { "q", "Q", "m", "H", "M", "L" })

-- move
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "J", "5gj")
vim.keymap.set({ "n", "x" }, "K", "5gk")

-- search
local in_place_search = function(direction)
  local pattern
  local mode = vim.fn.mode()
  if mode:match("[vV\22]") then
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local region = vim.fn.getregion(start_pos, end_pos, { type = mode })
    local escaped = vim.tbl_map(function(line) return vim.fn.escape(line, "/\\") end, region)
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
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")
vim.keymap.set({ "n", "x" }, "#", function() in_place_search("backward") end)
vim.keymap.set({ "n", "x" }, "*", function() in_place_search("forward") end)

-- save and quit
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit" })

-- add and sub
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { desc = "Number Add" })
vim.keymap.set({ "n", "x" }, "-", "<C-x>", { desc = "Number Subtract" })
vim.keymap.set({ "n", "x" }, "g+", "g<C-a>", { desc = "Number Add (multiple)" })
vim.keymap.set({ "n", "x" }, "g-", "g<C-x>", { desc = "Number Subtract (multiple)" })

-- indent
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- split
local split_win = function(split)
  return function() vim.api.nvim_open_win(0, true, { split = split }) end
end
vim.keymap.set("n", "<leader><Right>", split_win("right"), { desc = "Split Vertical (Right)" })
vim.keymap.set("n", "<leader><Left>", split_win("left"), { desc = "Split Vertical (Left)" })
vim.keymap.set("n", "<leader><Down>", split_win("below"), { desc = "Split Horizontal (Below)" })
vim.keymap.set("n", "<leader><Up>", split_win("above"), { desc = "Split Horizontal (Above)" })
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- diff
vim.keymap.set("n", "<leader>dd", function()
  if vim.wo[0][0].diff then
    vim.cmd("windo diffoff")
  else
    vim.cmd("windo diffthis")
  end
end, { desc = "Diff Toggle" })

-- macro
vim.keymap.set("n", "<leader>M", "q", { desc = "Macro Record" })

-- normal mode commands
vim.keymap.set("x", "<leader>n", ":normal ")

-- join lines
vim.keymap.set({ "n", "x" }, "<leader>j", "J", { desc = "Join Lines" })

-- diagnostics
vim.keymap.set("n", "<leader>x", vim.diagnostic.setqflist, { desc = "Lsp Diagnostics List" })

-- terminal
vim.keymap.set("t", "<C-'>", "<C-\\><C-n>")

-- q to close
vim.api.nvim_create_autocmd("FileType", {
  group = Utils.autocmd.default_group,
  pattern = { "help", "qf", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd.close()
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, { buffer = event.buf })
    end)
  end,
})
