---@type PicoPack.Spec
local spec = {
  PicoPack.url.gh("KurisuNya/nvim-gtd"),
  event = PicoPack.event.VeryLazy,
}

local method_maps = {
  ["textDocument/definition"] = {
    {
      "n",
      "gd",
      function() require("gtd").exec({ command = "edit" }) end,
      { desc = "Lsp Goto Definition" },
    },
  },
}

spec.config = function()
  require("gtd").setup({})
  for method, maps_ in pairs(method_maps) do
    Utils.lsp.on_attach_by_method(
      method,
      function(_, bufnr) Utils.keymap.set_maps(maps_, { buffer = bufnr }) end
    )
  end
end

PicoPack.register(spec)
