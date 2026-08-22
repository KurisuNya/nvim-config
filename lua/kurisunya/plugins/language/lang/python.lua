vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function() vim.wo[0][0].colorcolumn = "88" end,
})

Manager.opts_extend("neo-tree.nvim", {
  custom = { hide_by_name = { "__pycache__" } },
}, { extend = "custom.hide_by_name" })

Manager.opts_extend("nvim-treesitter", {
  ensure_installed = { "python" },
}, { extend = "ensure_installed" })

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "ty", "basedpyright", "ruff", "debugpy" },
}, { extend = "ensure_installed" })

Manager.opts_extend("conform.nvim", {
  custom = {
    formatters = {
      { "ruff_format", filetypes = { "python" } },
      { "ruff_organize_imports", filetypes = { "python" } },
    },
  },
}, { extend = "custom.formatters" })

Manager.on_loaded("nvim-lspconfig", function()
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
          inlayHints = { variableTypes = false },
        },
        disableTaggedHints = false,
      },
    },
  })
  vim.lsp.enable("basedpyright")
  -- vim.lsp.enable("ty")
end)

---@type Manager.Spec
local dap_spec = {
  Manager.url.gh("mfussenegger/nvim-dap-python"),
  dependencies = {
    Manager.url.gh("mfussenegger/nvim-dap"),
    Manager.url.gh("mason-org/mason.nvim"),
  },
  filetype = "python",
}

dap_spec.config = function()
  local mr = require("mason-registry")
  if not mr.is_installed("debugpy") then
    vim.notify("debugpy is not installed. Please run :MasonInstall debugpy", vim.log.levels.WARN)
  end
  local path = vim.fn.expand("$MASON/packages/debugpy")
  if Utils.os.is_windows() then
    require("dap-python").setup(path .. "/venv/Scripts/python.exe")
  else
    require("dap-python").setup(path .. "/venv/bin/python")
  end
end

Manager.on_loaded("nvim-dap", function()
  local dap = require("dap")
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      justMyCode = true,
    },
    {
      type = "python",
      request = "launch",
      name = "Not only my code",
      program = "${file}",
      justMyCode = false,
    },
  }
end)

Manager.add(dap_spec)

---@type Manager.Spec
local venv_spec = {
  Manager.url.gh("linux-cultist/venv-selector.nvim"),
  filetype = "python",
}

local venv_maps = {
  { "n", "<leader>cv", "<CMD>VenvSelect<CR>", { desc = "Python Venv Choose" } },
  {
    "n",
    "<leader>cV",
    function()
      require("venv-selector").deactivate()
      vim.notify("Deactivated Python Venv")
    end,
    { desc = "Python Venv Deactivate" },
  },
}

venv_spec.opts = {}

venv_spec.config = function(opts)
  require("venv-selector").setup(opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(ev) Utils.keymap.set_maps(venv_maps, { buffer = ev.buf }) end,
  })
end

Manager.add(venv_spec)

local neotest_spec = {
  Manager.url.gh("nvim-neotest/neotest-python"),
}

Manager.opts_extend("neotest", {
  adapters = {
    function()
      Manager.load("neotest-python")
      Manager.load("venv-selector.nvim")
      local opts = {
        dap = { justMyCode = false },
        python = function() return require("venv-selector").python() end,
      }
      return require("neotest-python")(opts)
    end,
  },
}, { extend = "adapters" })

Manager.add(neotest_spec)
