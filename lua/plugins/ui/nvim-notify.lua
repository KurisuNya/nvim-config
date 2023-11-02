---@diagnostic disable: missing-fields
local status, notify = pcall(require, "notify")
if not status then
	return
end
notify.setup({
	render = "wrapped-compact",
	stages = "static",
	timeout = 4000,
})
