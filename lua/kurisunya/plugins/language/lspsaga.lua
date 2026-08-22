---@type Manager.Spec
local spec = {
  Manager.url.gh("nvimdev/lspsaga.nvim"),
  dependencies = { Manager.url.gh("nvim-mini/mini.icons") },
  event = Manager.event.VeryLazy,
}

---@param severity string
local prev_diagnostic = function(severity)
  return function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity[severity] })
  end
end

---@param severity string
local next_diagnostic = function(severity)
  return function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity[severity] })
  end
end

local maps = {
  { "n", "<leader>v", "<CMD>Lspsaga outline<CR>", { desc = "Outline Toggle" } },
}
local method_maps = {
  ["textDocument/codeAction"] = {
    { "n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", { desc = "Lsp Code Action" } },
  },
  ["textDocument/reference"] = {
    { "n", "gr", "<CMD>Lspsaga finder<CR>", { desc = "Lsp Find Reference" } },
  },
  ["textDocument/rename"] = {
    { "n", "<leader>rn", "<CMD>Lspsaga rename<CR>", { desc = "Lsp Rename" } },
  },
  ["textDocument/diagnostics"] = {
    { "n", "<leader>D", "<CMD>Lspsaga show_buf_diagnostics<CR>", { desc = "Lsp Line Diagnostic" } },
    { "n", "[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous Lsp Diagnostic" } },
    { "n", "]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Lsp Diagnostic" } },
    { "n", "[w", prev_diagnostic("WARN"), { desc = "Previous Lsp Diagnostic(Warning)" } },
    { "n", "]w", next_diagnostic("WARN"), { desc = "Next Lsp Diagnostic(Warning)" } },
    { "n", "[e", prev_diagnostic("ERROR"), { desc = "Previous Lsp Diagnostic(Error)" } },
    { "n", "]e", next_diagnostic("ERROR"), { desc = "Next Lsp Diagnostic(Error)" } },
  },
}
local finder_mappings = { toggle_or_open = "<CR>", quit = "q" }
local code_action_mappings = { quit = "q", exec = "<CR>" }
local outline_mappings = { toggle_or_jump = "<Tab>", quit = "q", jump = "<CR>" }

spec.init = function()
  Utils.keymap.del({ "n", "x" }, { "grr", "gri", "grt", "gra", "grn", "grx", "gO" })
end

spec.opts = {
  symbol_in_winbar = { enable = false },
  lightbulb = { enable = false },
  ui = {
    border = Config.border_style,
    expand = Icons.fillchars.foldclose,
    collapse = Icons.fillchars.foldopen,
    lines = { "└", "├", "│", "─", "┌" },
  },
  rename = { in_select = false, auto_save = true },
  implement = { enable = true, sign = false },
  code_action = { keys = code_action_mappings },
  finder = { keys = finder_mappings },
  outline = { keys = outline_mappings },
}

spec.config = function(opts)
  require("lspsaga").setup(opts)
  Utils.keymap.set_maps(maps)
  for method, maps_ in pairs(method_maps) do
    Utils.lsp.on_attach_by_method(
      method,
      function(_, bufnr) Utils.keymap.set_maps(maps_, { buffer = bufnr }) end
    )
  end
end

Manager.opts_extend("projections.nvim", {
  sessions_ignore_filetypes = { "sagaoutline" },
}, { extend = "sessions_ignore_filetypes" })

Manager.add(spec)
