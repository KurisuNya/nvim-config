-- import nvim-indent_blankline safely
local indent_blankline_setup, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_setup then
	return
end
indent_blankline.setup({
	space_char_blankline = " ",
	show_current_context = true,
})
