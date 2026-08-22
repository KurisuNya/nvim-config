local H = {}

H.installed = nil ---@type table<string,boolean>?
H.queries = {} ---@type table<string,boolean>

---@param update boolean?
function H.get_installed(update)
  if update then
    H.installed, H.queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      H.installed[lang] = true
    end
  end
  return H.installed or {}
end

---@param lang string
---@param query string
function H.have_query(lang, query)
  local key = lang .. ":" .. query
  if H.queries[key] == nil then
    H.queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return H.queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
function H.have(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or H.get_installed()[lang] == nil then
    return false
  end
  if query and not H.have_query(lang, query) then
    return false
  end
  return true
end

local spec = {
  { src = Manager.url.gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  dependencies = { Manager.url.gh("nvim-treesitter/nvim-treesitter-context") },
  build = function() vim.cmd("TSUpdate") end,
  event = Manager.event.VeryLazy,
  lazy = vim.fn.argc(-1) == 0,
}

spec.opts = {
  ensure_installed = {
    "bash",
    "regex",
    "markdown",
    "markdown_inline",
    "gitcommit",
    "gitignore",
    "gitattributes",
  },
  highlight = { enable = true },
  indent = { enable = true },
  fold = { enable = true },
  context = { enable = true, max_lines = 3 },
}

spec.config = function(opts)
  require("treesitter-context").setup(opts.context)
  local TS = require("nvim-treesitter")

  local tbl = opts.ensure_installed or {}
  tbl = Utils.misc.list_filter_same(tbl)
  H.get_installed(true)
  local install = vim.tbl_filter(function(lang) return not H.have(lang) end, tbl)
  if #install > 0 then
    TS.install(install, { summary = true }):await(function() H.get_installed(true) end)
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = Utils.autocmd.new_group("treesitter"),
    callback = function(ev)
      local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
      if not H.have(ft) then
        return
      end

      ---@param feat string
      ---@param query string
      local function enabled(feat, query)
        local f = opts[feat] or {}
        return f.enable ~= false
          and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
          and H.have(ft, query)
      end

      if enabled("highlight", "highlights") then
        pcall(vim.treesitter.start)
      end
      if enabled("indent", "indents") then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      if enabled("fold", "folds") then
        local support_fold = function(c) return c:supports_method("textDocument/foldingRange") end
        local lsp_takes = vim.iter(vim.lsp.get_clients({ bufnr = ev.buf })):any(support_fold)
        if not lsp_takes then
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end
      end
    end,
  })
end

Manager.opts_extend("mason.nvim", {
  ensure_installed = { "tree-sitter-cli" },
}, { extend = "ensure_installed" })

Manager.add(spec)
