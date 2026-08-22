---@type Manager.Spec
local spec = {
  {
    src = Manager.url.gh("gnikdroy/projections.nvim"),
    version = "pre_release",
  },
  event = Manager.event.VeryLazy,
}

local maps = function()
  local m = {
    { "n", "<leader>fp", "<CMD>Telescope projections<CR>", { desc = "Telescope Project" } },
  }
  return Manager.have("telescope.nvim") and m or {}
end

spec.init = function() vim.opt.sessionoptions:append("globals") end

spec.opts = {
  workspaces = Config.workspaces,
  sessions_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/projections_sessions"),
  sessions_ignore_filetypes = { "gitcommit", "gitrebase", "help", "qf", "netrw" },
}

local sessions_ignore_filetypes = {}

local close_ignore_buffers = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local filetype = vim.bo[bufnr].filetype
    if sessions_ignore_filetypes[filetype] then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

spec.config = function(opts)
  for _, ft in ipairs(opts.sessions_ignore_filetypes) do
    sessions_ignore_filetypes[ft] = true
  end
  opts.store_hooks = { pre = close_ignore_buffers }
  require("projections").setup(opts)

  if Manager.have("telescope.nvim") then
    Manager.on_loaded(
      "telescope.nvim",
      function() require("telescope").load_extension("projections") end
    )
  end

  local Session = require("projections.session")
  vim.api.nvim_create_user_command(
    "ProjectionsLastSession",
    function() Session.restore_latest() end,
    {}
  )
  vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    group = Utils.autocmd.new_group("store_session"),
    callback = function() Session.store(vim.uv.cwd()) end,
  })

  Utils.keymap.set_maps(maps())
end

Manager.add(spec)
