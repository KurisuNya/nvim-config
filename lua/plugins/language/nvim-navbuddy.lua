local M = {}
M.config = function()
	local icons = require("plugins.ui.icons")
	local mappings = require("keymaps.plugins.nvim-navbuddy").mappings()

	require("nvim-navbuddy").setup({
		window = {
			border = "rounded",
			size = "90%",
		},
		icons = {
			File = icons.symbols.File,
			Module = icons.symbols.Module,
			Namespace = icons.symbols.Namespace,
			Package = icons.symbols.Package,
			Class = icons.symbols.Class,
			Method = icons.symbols.Method,
			Property = icons.symbols.Property,
			Field = icons.symbols.Field,
			Constructor = icons.symbols.Constructor,
			Enum = icons.symbols.Enum,
			Interface = icons.symbols.Interface,
			Function = icons.symbols.Function,
			Variable = icons.symbols.Variable,
			Constant = icons.symbols.Constant,
			String = icons.symbols.String,
			Number = icons.symbols.Number,
			Boolean = icons.symbols.Boolean,
			Array = icons.symbols.Array,
			Object = icons.symbols.Object,
			Key = icons.symbols.Key,
			Null = icons.symbols.Null,
			EnumMember = icons.symbols.EnumMember,
			Struct = icons.symbols.Struct,
			Event = icons.symbols.Event,
			Operator = icons.symbols.Operator,
			TypeParameter = icons.symbols.TypeParameter,
		},
		use_default_mappings = true,
		mappings = mappings,
		lsp = { auto_attach = true },
	})
	local keymap = require("keymaps.plugins.nvim-navbuddy").keymaps.symbols
	KurisuNya.utils.lsp_keymap_set_by_method("textDocument/documentSymbol", keymap)
end
return M
