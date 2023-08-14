local neoscroll_status, neoscroll = pcall(require, "neoscroll")
if not neoscroll_status then
	return
end
neoscroll.setup()
