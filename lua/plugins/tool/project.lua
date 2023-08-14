local status, project = pcall(require, "project_nvim")
if not status then
	return
end

project.setup({
	manual_mode = true,
})
