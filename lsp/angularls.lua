local root = vim.fs.dirname(vim.fs.find({
	"angular.json",
	"nx.json",
}, { upward = true })[1])

local project_lib_path = vim.fn.expand("./node_modules/")
local global_lib_path = vim.fn.expand("~/.bun/install/global/node_modules")

return {
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		global_lib_path,
		project_lib_path,
		"--ngProbeLocations",
		global_lib_path,
		project_lib_path,
		"--includeCompletionsWithSnippetText",
	},
	root_dir = root,
}
