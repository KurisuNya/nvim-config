local status, numb = pcall(require, "numb")
if not status then
	return
end
numb.setup()
