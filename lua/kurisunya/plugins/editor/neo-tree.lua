---@type Manager.Spec
local spec = {
  {
    src = Manager.url.gh("nvim-neo-tree/neo-tree.nvim"),
    version = vim.version.range("3"),
  },
  dependencies = {
    Manager.url.gh("nvim-mini/mini.icons"),
    Manager.url.gh("nvim-lua/plenary.nvim"),
    Manager.url.gh("MunifTanjim/nui.nvim"),
  },
  event = Manager.event.VeryLazy,
}

local maps = {
  { "n", "<leader>e", "<CMD>Neotree toggle dir=./<CR>", { desc = "NeoTree Toggle" } },
}
local normal_mappings = {
  ["<space>"] = "none",
  ["l"] = "none",
  ["t"] = "none",
  ["w"] = "none",
  ["C"] = "none",
  ["z"] = "none",
  ["zC"] = "close_all_nodes",
  ["zO"] = "expand_all_nodes",
  ["A"] = "none",
  ["b"] = "none",
  ["c"] = "none",
  ["m"] = "none",
}
local filesystem_mappings = {
  ["#"] = "none",
  ["D"] = "none",
}

spec.opts = function()
  local opts = {
    custom = {
      hide_by_name = {},
      hide_by_pattern = {},
      always_show = { ".gitignore", ".gitattributes" },
      never_show = {},
      never_show_by_pattern = {},
    },
    close_if_last_window = true,
    popup_border_style = Config.border_style,
    default_component_configs = {
      modified = { symbol = Icons.git.modified, highlight = "NeoTreeModified" },
      git_status = {
        symbols = {
          added = "",
          modified = "",
          unstaged = Icons.git.unstaged,
          staged = Icons.git.staged,
          conflict = Icons.git.conflict,
          renamed = Icons.git.renamed,
          untracked = Icons.git.untracked,
          deleted = Icons.git.deleted,
          ignored = Icons.git.ignored,
        },
      },
    },
    window = { width = 35, mappings = normal_mappings },
    filesystem = {
      filtered_items = { hide_dotfiles = true, hide_gitignored = false },
      follow_current_file = { enabled = true, leave_dirs_open = false },
      use_libuv_file_watcher = true,
      window = { mappings = filesystem_mappings },
    },
  }
  local events = require("neo-tree.events")
  local function close_tree() require("neo-tree.command").execute({ action = "close" }) end
  opts.event_handlers = { { event = events.FILE_OPENED, handler = close_tree } }
  return opts
end

spec.config = function(opts)
  opts.filesystem.filtered_items.hide_by_name = opts.custom.hide_by_name
  opts.filesystem.filtered_items.hide_by_pattern = opts.custom.hide_by_pattern
  opts.filesystem.filtered_items.always_show = opts.custom.always_show
  opts.filesystem.filtered_items.never_show = opts.custom.never_show
  opts.filesystem.filtered_items.never_show_by_pattern = opts.custom.never_show_by_pattern
  require("neo-tree").setup(opts)
  Utils.keymap.set_maps(maps)
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = { "neo-tree" },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
