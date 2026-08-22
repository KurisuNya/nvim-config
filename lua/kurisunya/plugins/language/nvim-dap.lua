---@type Manager.Spec
local dap_spec = {
  Manager.url.gh("mfussenegger/nvim-dap"),
  dependencies = {
    Manager.url.gh("mason-org/mason.nvim"),
    Manager.url.gh("jay-babu/mason-nvim-dap.nvim"),
    Manager.url.gh("theHamsta/nvim-dap-virtual-text"),
  },
  event = Manager.event.VeryLazy,
}

---@type Manager.Spec
local ui_spec = {
  Manager.url.gh("rcarriga/nvim-dap-ui"),
  dependencies = {
    Manager.url.gh("nvim-neotest/nvim-nio"),
    Manager.url.gh("mfussenegger/nvim-dap"),
  },
  event = Manager.event.VeryLazy,
}

local dap_maps = {
  { "n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Dap Breakpoint Toggle" } },
  { "n", "<leader>dc", "<CMD>DapContinue<CR>", { desc = "Dap Run/Continue" } },
  { "n", "<leader>dt", "<CMD>DapTerminate<CR>", { desc = "Dap Terminate" } },
  { "n", "<leader>]", "<CMD>DapStepOver<CR>", { desc = "Dap StepOver" } },
  { "n", "<leader>}", "<CMD>DapStepInto<CR>", { desc = "Dap StepIn" } },
  { "n", "<leader>{", "<CMD>DapStepOut<CR>", { desc = "Dap StepOut" } },
}

local ui_maps = {
  {
    "n",
    "<leader>du",
    function()
      if vim.g.dapui_opened then
        require("dapui").close()
        vim.g.dapui_opened = false
      else
        require("dapui").open({ reset = true })
        vim.g.dapui_opened = true
      end
    end,
    { desc = "Dap UI Toggle" },
  },
  { "n", "<leader>de", function() require("dapui").eval() end, { desc = "Dap UI Eval" } },
}
local ui_normal_mappings = {
  edit = "e",
  expand = "<CR>",
  open = "o",
  remove = "d",
  repl = "r",
  toggle = "t",
}
local ui_float_mappings = { close = { "q", "<Esc>" } }

dap_spec.config = function()
  ---@diagnostic disable-next-line: missing-fields
  require("mason-nvim-dap").setup({ handlers = {} })
  require("nvim-dap-virtual-text").setup({})
  Utils.keymap.set_maps(dap_maps)

  local sign = function(icon, hl) return { text = icon, texthl = hl, linehl = hl, numhl = hl } end
  vim.fn.sign_define("DapBreakpoint", sign(Icons.dap.BreakPoint, "DapBreakpoint"))
  vim.fn.sign_define("DapBreakpointCondition", sign(Icons.dap.BreakPointCondition, "DapBreakpoint"))
  vim.fn.sign_define("DapBreakpointRejected", sign(Icons.dap.BreakPointRejected, "DapBreakpoint"))
  vim.fn.sign_define("DapLogPoint", sign(Icons.dap.LogPoint, "DapLogPoint"))
  vim.fn.sign_define("DapStopped", sign(Icons.dap.Stopped, "DapStopped"))
end

ui_spec.init = function() vim.g.dapui_opened = false end

ui_spec.opts = {
  force_buffers = true,
  icons = {
    expanded = Icons.fillchars.foldopen,
    collapsed = Icons.fillchars.foldclose,
    current_frame = Icons.misc.indicator,
  },
  mappings = ui_normal_mappings,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.75 },
        { id = "watches", size = 0.25 },
      },
      size = 0.25,
      position = "right",
    },
    {
      elements = {
        { id = "console", size = 0.4 },
        { id = "breakpoints", size = 0.3 },
        { id = "stacks", size = 0.3 },
      },
      position = "bottom",
      size = 0.25,
    },
  },
  floating = {
    max_height = 0.5,
    max_width = 0.5,
    border = Config.border_style,
    mappings = ui_float_mappings,
  },
  render = { indent = 1, max_value_lines = 85 },
}

ui_spec.config = function(opts)
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup(opts)
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
    vim.g.dapui_opened = true
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    vim.g.dapui_opened = false
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    vim.g.dapui_opened = false
  end

  Utils.keymap.set_maps(ui_maps)
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = {
    "dap_repl",
    "dapui_console",
    "dapui_stacks",
    "dapui_scopes",
    "dapui_breakpoints",
  },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(dap_spec)
Manager.add(ui_spec)
