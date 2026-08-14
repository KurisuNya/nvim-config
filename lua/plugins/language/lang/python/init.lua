PluginVars.filetype_colorcolumn.python = "88"
PluginVars.insert(PluginVars.neotree_hide_by_name, "__pycache__")

PluginVars.insert(PluginVars.treesitter_ensure_installed, "python")
PluginVars.insert(PluginVars.mason_ensure_installed, "ty")
PluginVars.insert(PluginVars.mason_ensure_installed, "basedpyright")
PluginVars.insert(PluginVars.mason_ensure_installed, "ruff")
PluginVars.insert(PluginVars.lualine_hidden_lsp, "ruff")

PluginVars.insert(PluginVars.conform_formatters, { name = "ruff_format", filetypes = { "python" } })
PluginVars.insert(PluginVars.conform_formatters, { name = "ruff_organize_imports", filetypes = { "python" } })

PluginVars.insert(PluginVars.lsp_config, function()
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

return {
  require("plugins.language.lang.python.venv-selector"),
  require("plugins.language.lang.python.nvim-dap-python"),
  require("plugins.language.lang.python.neotest-python"),
}
