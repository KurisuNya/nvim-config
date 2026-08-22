---@type Manager.Spec
local spec = {
  Manager.url.gh("stevearc/conform.nvim"),
  event = Manager.event.VeryLazy,
}

--- @class ConformFormatter
--- @field [1] string
--- @field filetypes string[]
--- @field priority? integer
--- @field config? table<string, any>

spec.opts = {
  custom = {
    formatters = {}, --- @type ConformFormatter[]
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
}

spec.config = function(opts)
  local formatters = opts.custom.formatters or {}
  table.sort(formatters, function(a, b) return (a.priority or 0) > (b.priority or 0) end)

  local filetype_formatters = {}
  for _, formatter in ipairs(formatters) do
    for _, ft in ipairs(formatter.filetypes) do
      if not filetype_formatters[ft] then
        filetype_formatters[ft] = {}
      end
      table.insert(filetype_formatters[ft], formatter[1])
    end
  end

  opts.formatters_by_ft = filetype_formatters
  require("conform").setup(opts)

  for _, formatter in ipairs(formatters) do
    if formatter.config then
      require("conform").formatters[formatter[1]] = formatter.config
    end
  end
end

Manager.add(spec)
