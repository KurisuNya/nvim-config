local which_key_status, which_key = pcall(require, "which-key")
if not which_key_status then
	return
end
which_key.setup({})
