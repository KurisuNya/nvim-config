local noice_status, noice = pcall(require, "noice")
if not noice_status then
	return
end
local nvim_jdtls_status, nvim_jdtls = pcall(require, "jdtls")
if not nvim_jdtls_status then
	return
end

vim.opt.cmdheight = 0
noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	markdown = {
		hover = {
			["|(%S-)|"] = vim.cmd.help, -- vim help links
			["%[.-%]%((jdt://%S-)%)"] = nvim_jdtls.open_classfile,
			["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})
