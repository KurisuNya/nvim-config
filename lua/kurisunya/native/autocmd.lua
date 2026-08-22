-- check if need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = Utils.autocmd.default_group,
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd.checktime()
    end
  end,
})

-- disable auto comment
vim.api.nvim_create_autocmd("FileType", {
  group = Utils.autocmd.default_group,
  callback = function()
    for _, flag in ipairs({ "c", "r", "o" }) do
      vim.opt_local.formatoptions:remove(flag)
    end
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = Utils.autocmd.default_group,
  callback = function() vim.hl.hl_op({ hl_group = "Visual", timeout = 400 }) end,
})

-- restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = Utils.autocmd.default_group,
  callback = function(event)
    local buf = event.buf
    if vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- auto resize split
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = Utils.autocmd.default_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd.tabnext(current_tab)
  end,
})

-- auto create dir
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = Utils.autocmd.default_group,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
