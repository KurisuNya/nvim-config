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
			["|(%S-)|"] = vim.cmd.help,
			["%[.-%]%((jdt%S-)%)"] = nvim_jdtls.open_classfile,
			["%[.-%]%((http%S-)%)"] = require("noice.util").open,
		},
		open_link_keys = "H",
	},
	presets = {
		bottom_search = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	views = {
		hover = {
			size = {
				width = "auto",
				height = "auto",
				max_height = 30,
				max_width = 90,
			},
			win_options = {
				wrap = true,
				linebreak = true,
			},
		},
	},
})
