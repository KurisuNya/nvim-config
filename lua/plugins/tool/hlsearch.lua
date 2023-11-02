local status, hlsearch = pcall(require, "hlsearch")
if not status then
	return
end
hlsearch.setup()
