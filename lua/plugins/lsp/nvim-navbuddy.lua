local status, nvim_navbuddy = pcall(require, "nvim-navbuddy")
if not status then
	return
end
local icons = require("plugins.ui.icons")
local map_list = require("core.keymaps").nvim_navbuddy

nvim_navbuddy.setup({
	window = {
		border = "rounded",
		size = "70%",
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
	use_default_mappings = false,
	mappings = map_list,
	lsp = {
		auto_attach = true,
	},
})
