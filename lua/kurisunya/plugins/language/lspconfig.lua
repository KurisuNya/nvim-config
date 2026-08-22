---@type Manager.Spec
local spec = {
  Manager.url.gh("neovim/nvim-lspconfig"),
  event = Manager.event.VeryLazy,
}

local method_maps = {
  ["textDocument/hover"] = {
    { "n", "H", function() vim.lsp.buf.hover() end, { desc = "Lsp Hover Doc" } },
  },
}

spec.opts = {
  folding_range = true,
  inlay_hint = false,
}

spec.config = function(opts)
  vim.lsp.log.set_level("off")

  -- folding
  if opts.folding_range then
    Utils.lsp.on_attach_by_method("textDocument/foldingRange", function()
      if vim.wo[0][0].foldmethod == "diff" then
        return
      end
      vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end)
  end

  -- inlay hints
  if opts.inlay_hint then
    local methods = vim.lsp.protocol.Methods
    local inlay_hint_handler = vim.lsp.handlers[methods["textDocument_inlayHint"]]
    vim.lsp.handlers[methods["textDocument_inlayHint"]] = function(err, result, ctx, config)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client then
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        result = vim.tbl_filter(function(h) return h.position.line + 1 == row end, result or {})
      end
      inlay_hint_handler(err, result, ctx, config)
    end
    local inlay_hints_group = Utils.autocmd.new_group("lsp_inlay_hints")
    Utils.lsp.on_attach_by_method("textDocument/inlayHint", function(_, bufnr)
      if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "" then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = inlay_hints_group,
          buffer = bufnr,
          callback = function() vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end,
        })
      end
    end)
  end

  -- keymaps
  for method, maps in pairs(method_maps) do
    Utils.lsp.on_attach_by_method(
      method,
      function(_, bufnr) Utils.keymap.set_maps(maps, { buffer = bufnr }) end
    )
  end
end

Manager.add(spec)
