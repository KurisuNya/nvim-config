---@type Manager.Spec
local main_spec = {
  Manager.url.gh("nvim-telescope/telescope.nvim"),
  event = Manager.event.VeryLazy,
}

---@type string?
local build_cmd
for _, cmd in ipairs({ "make", "cmake", "gmake" }) do
  if vim.fn.executable(cmd) == 1 then
    build_cmd = cmd
    break
  end
end

---@type Manager.Spec
local fzf_spec = {
  Manager.url.gh("nvim-telescope/telescope-fzf-native.nvim"),
  build = (build_cmd ~= "cmake") and "make"
    or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
      .. "cmake --build build --config Release && "
      .. "cmake --install build --prefix build",
}

main_spec.dependencies = {
  Manager.url.gh("nvim-mini/mini.icons"),
  Manager.url.gh("nvim-lua/plenary.nvim"),
  Manager.url.gh("nvim-telescope/telescope-fzf-native.nvim"),
  Manager.url.gh("nvim-telescope/telescope-ui-select.nvim"),
}

local maps = {
  { "n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Telescope File" } },
  { "n", "<leader>fs", "<CMD>Telescope live_grep<CR>", { desc = "Telescope Grep" } },
  { "n", "<leader>fc", "<CMD>Telescope git_commits<CR>", { desc = "Telescope Commit" } },
  { "n", "<leader>fb", "<CMD>Telescope git_branches<CR>", { desc = "Telescope Branch" } },
}
local mappings = {
  n = {
    ["<ESC>"] = "close",
    ["q"] = "close",
    ["J"] = function(bufnr)
      for _ = 1, 5 do
        require("telescope.actions").move_selection_next(bufnr)
      end
    end,
    ["K"] = function(bufnr)
      for _ = 1, 5 do
        require("telescope.actions").move_selection_previous(bufnr)
      end
    end,
  },
}

-- stylua: ignore start
local livegrep_cmd = {
  "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
  "--column", "--smart-case", "--trim", "--hidden", "--glob", "!**/.git/*"
}
-- stylua: ignore end
local find_files_cmd = { "fd", "--type", "file", "--hidden", "--color", "never", "-E", "**/.git/*" }

main_spec.opts = function()
  return {
    defaults = {
      mappings = mappings,
      borderchars = Icons.borderchars[Config.border_style],
      vimgrep_arguments = livegrep_cmd,
    },
    pickers = { find_files = { find_command = find_files_cmd } },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          borderchars = Icons.borderchars[Config.border_style],
        }),
      },
    },
  }
end

main_spec.config = function(opts)
  require("telescope").setup(opts)
  local ok, _ = pcall(require("telescope").load_extension, "fzf")
  if not ok then
    vim.notify(
      "Failed to load `telescope-fzf-native.nvim`.\nPlease ensure it is built correctly.",
      vim.log.levels.ERROR
    )
  end
  require("telescope").load_extension("ui-select")
  Utils.keymap.set_maps(maps)
end

Manager.add(fzf_spec)
Manager.add(main_spec)
