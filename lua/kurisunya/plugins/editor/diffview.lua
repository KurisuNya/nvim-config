---@type Manager.Spec
local spec = {
  Manager.url.gh("dlyongemallo/diffview.nvim"),
  event = Manager.event.VeryLazy,
}

local maps = {
  { "n", "<leader>gD", "<CMD>DiffviewOpen<CR>", { desc = "Git Diff Project" } },
  { "n", "<leader>gH", "<CMD>DiffviewFileHistory<CR>", { desc = "Git History Project" } },
}
local view_mappings = function()
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
local file_panel_mappings = function()
  local actions = require("diffview.actions")
  local list = {
    -- help panel
    { "n", "g?", actions.help("file_panel"), { desc = "? Open Help Panel" } },
    -- basic
    { "n", "<leader>q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } },
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
local file_history_panel_mappings = function()
  local actions = require("diffview.actions")
  local list = {
    -- panel
    { "n", "g?", actions.help("file_panel"), { desc = "? Open Help Panel" } },
    { "n", "g!", actions.options, { desc = "Open Option Panel" } },
    --basic
    { "n", "<leader>q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } },
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
local help_panel_mappings = function()
  local actions = require("diffview.actions")
  local list = {
    { "n", "q", actions.close, { desc = "Close Help Menu" } },
    { "n", "<esc>", actions.close, { desc = "Close Help Menu" } },
  }
  return list
end
local option_panel_mappings = function()
  local actions = require("diffview.actions")
  local list = {
    { "n", "g?", actions.help("option_panel"), { desc = "? Open Help Panel" } },
    { "n", "<CR>", actions.select_entry, { desc = "Change Current Option" } },
    { "n", "q", actions.close, { desc = "Close Option Panel" } },
    { "n", "<esc>", actions.close, { desc = "Close Option Panel" } },
  }
  return list
end

spec.init = function() vim.g.diffview_opened = false end

local open_hooks = {}
local close_hooks = {}
local original_buffers = {}

local function get_buffers()
  local buffers = {}
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(buffer) == 1 then
      table.insert(buffers, buffer)
    end
  end
  return buffers
end

local view_opened_hook = function()
  vim.g.diffview_opened = true
  for _, func in ipairs(open_hooks) do
    func()
  end
  for _, buffer in ipairs(get_buffers()) do
    vim.api.nvim_set_option_value("buflisted", false, { buf = buffer })
    original_buffers[buffer] = true
  end
end

local view_close_hook = function()
  vim.g.diffview_opened = false
  for _, func in ipairs(close_hooks) do
    func()
  end
  for _, buffer in ipairs(get_buffers()) do
    if not original_buffers[buffer] then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
  end
  for _, buffer in ipairs(vim.tbl_keys(original_buffers)) do
    vim.api.nvim_set_option_value("buflisted", true, { buf = buffer })
  end
end

spec.opts = function()
  return {
    custom = {
      view_opened_hooks = {},
      view_close_hooks = {},
    },
    enhanced_diff_hl = true,
    show_help_hints = false,
    file_panel = {
      listing_style = "list",
      win_config = { position = "bottom", height = 10 },
    },
    keymaps = {
      disable_defaults = true,
      view = view_mappings(),
      file_panel = file_panel_mappings(),
      file_history_panel = file_history_panel_mappings(),
      help_panel = help_panel_mappings(),
      option_panel = option_panel_mappings(),
    },
  }
end

spec.config = function(opts)
  open_hooks = opts.custom.view_opened_hooks
  close_hooks = opts.custom.view_close_hooks
  opts.hooks = { view_opened = view_opened_hook, view_closed = view_close_hook }
  require("diffview").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = {
    "DiffviewFiles",
    "DiffviewFileHistory",
  },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
