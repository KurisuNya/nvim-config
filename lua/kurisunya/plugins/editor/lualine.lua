---@type Manager.Spec
local spec = {
  Manager.url.gh("nvim-lualine/lualine.nvim"),
  dependencies = { Manager.url.gh("nvim-mini/mini.icons") },
  event = Manager.event.VeryLazy,
}

local space_enough = { function() return vim.o.columns >= 80 end }

local is_space_enough = function()
  return vim.iter(space_enough):all(function(f) return f() end)
end

local hidden_lsp = {}

local function lsp_get_client_names()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  local names = vim.tbl_map(function(c) return c and c.name or "" end, clients)
  names = vim.tbl_filter(function(name) return name ~= "" and not hidden_lsp[name] end, names)
  return table.concat(names, ", ")
end

spec.init = function()
  vim.o.showmode = false
  vim.o.ruler = false
  vim.o.cmdheight = 0
  vim.g.lualine_laststatus = vim.o.laststatus
  if vim.fn.argc(-1) > 0 then
    vim.o.statusline = " "
  else
    vim.o.laststatus = 0
  end
end

spec.opts = function()
  -- PERF: we don't need this lualine require madness 🤷
  local lualine_require = require("lualine_require")
  lualine_require.require = require

  vim.o.laststatus = vim.g.lualine_laststatus

  return {
    custom = {
      disabled_filetypes = {},
      hidden_lsp = {},
    },
    options = {
      theme = "auto",
      globalstatus = vim.o.laststatus == 3,
      section_separators = Config.statusline.section_separators,
      component_separators = Config.statusline.component_separators,
    },
    extensions = { "lazy", "quickfix" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
        {
          lsp_get_client_names,
          cond = is_space_enough,
          color = { fg = Utils.highlight.get_color("Comment").fg },
          icon = { Icons.misc.lsp, align = "right" },
        },
        { "encoding" },
        { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
        { "filetype", cond = is_space_enough },
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  }
end

spec.config = function(opts)
  opts.options.disabled_filetypes = { statusline = opts.custom.disabled_filetypes }
  for _, name in ipairs(opts.custom.hidden_lsp) do
    hidden_lsp[name] = true
  end

  -- space endough condition
  if Manager.have("diffview.nvim") then
    table.insert(space_enough, function() return not vim.g.diffview_opened end)
  end

  -- extensions
  if Manager.have("neo-tree.nvim") then
    table.insert(opts.extensions, "neo-tree")
  end

  if Manager.have("nvim-dap-ui") then
    table.insert(opts.extensions, "nvim-dap-ui")
  end

  if Manager.have("toggleterm.nvim") then
    table.insert(opts.extensions, "toggleterm")
  end

  if Manager.have("lspsaga.nvim") then
    local lspsaga_extension = {
      sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "sagaoutline" },
    }
    table.insert(opts.extensions, lspsaga_extension)
  end

  if Manager.have("neotest") then
    local neotest_extension = {
      sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "neotest-summary" },
    }
    table.insert(opts.extensions, neotest_extension)
  end

  if Manager.have("diffview.nvim") then
    local diffview_extension = {
      sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "DiffviewFiles" },
    }
    local diffview_history_extension = {
      sections = {
        lualine_a = { "filetype" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      filetypes = { "DiffviewFileHistory" },
    }
    table.insert(opts.extensions, diffview_extension)
    table.insert(opts.extensions, diffview_history_extension)
  end

  -- sections
  if Manager.have("gitsigns.nvim") then
    local head = { "b:gitsigns_head", icon = Icons.git.branch }
    local diff = {
      "diff",
      source = function()
        ---@diagnostic disable-next-line: undefined-field
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
      cond = is_space_enough,
    }
    table.insert(opts.sections.lualine_b, head)
    table.insert(opts.sections.lualine_b, diff)
  end

  if Manager.have("noice.nvim") then
    Manager.load("noice.nvim")
    local noice = require("noice")
    local command = {
      noice.api.status.command.get,
      cond = noice.api.status.command.has,
      padding = { left = 1, right = 0 },
    }
    local mode = {
      noice.api.status.mode.get,
      cond = function()
        if not noice.api.status.mode.has() then
          return false
        elseif not noice.api.status.mode.get():find("@") then
          return false
        end
        return true
      end,
    }
    table.insert(opts.sections.lualine_c, command)
    table.insert(opts.sections.lualine_c, mode)
  end

  if Manager.have("nvim-dap") then
    Manager.load("nvim-dap")
    local dap_info = {
      function() return require("dap").status() end,
      cond = function() return is_space_enough() and require("dap").status() ~= "" end,
      color = { fg = Utils.highlight.get_color("Debug").fg },
      icon = { Icons.misc.dap, align = "left" },
    }
    table.insert(opts.sections.lualine_x, 1, dap_info)
  end

  -- enable ui2 for better msg_show
  if not Manager.have("noice.nvim") then
    require("vim._core.ui2").enable()
  end

  require("lualine").setup(opts)
end

Manager.add(spec)
