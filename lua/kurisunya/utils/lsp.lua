Autocmd = require("kurisunya.utils.autocmd")

local M = {}

local on_attach_augroup = Autocmd.new_group("lsp_on_attach", true)

---@param filter fun(client: vim.lsp.Client, bufnr: integer): boolean
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.on_attach = function(filter, fn)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = on_attach_augroup,
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and filter(client, bufnr) then
        fn(client, bufnr)
      end
    end,
  })
end

---@param name string
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.on_attach_by_name = function(name, fn)
  M.on_attach(function(client, _) return client.name == name end, fn)
end

---@param method string
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.on_attach_by_method = function(method, fn)
  M.on_attach(function(client, _) return client:supports_method(method) end, fn)
end

return M
