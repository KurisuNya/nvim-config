local numb_status, numb = pcall(require, "numb")
if not numb_status then
	return
end
numb.setup()
