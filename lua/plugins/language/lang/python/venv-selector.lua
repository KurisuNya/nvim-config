local M = {
  "linux-cultist/venv-selector.nvim",
  opts = {},
  ft = "python",
}

M.keys = function()
  Utils.filetype_keymap_set("python", {
    mode = "n",
    key = "<leader>cv",
    cmd = "<Cmd>VenvSelect<CR>",
    opts = {
      desc = "Python Venv Choose",
      silent = true,
    },
  })
  Utils.filetype_keymap_set("python", {
    mode = "n",
    key = "<leader>cV",
    cmd = function()
      require("venv-selector").deactivate()
      vim.notify("Deactivated Python Venv")
    end,
    opts = {
      desc = "Python Venv Deactivate",
      silent = true,
    },
  })
end

return M
