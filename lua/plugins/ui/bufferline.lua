local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	highlights = {
		background = {
			fg = "#414868",
		},
	},
	options = {
		style_preset = {
			bufferline.style_preset.no_italic,
			bufferline.style_preset.no_bold,
		},
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-Tree",
				highlight = "Directory",
				text_align = "left",
			},
		},
		show_buffer_close_icons = false,
		separator_style = { "", "" },
		diagnostics = "nvim_lsp",
		---@diagnostic disable-next-line: unused-local
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
	},
})
