local root = vim.fs.dirname(vim.fs.find({
	"angular.json",
	"nx.json",
}, { upward = true })[1])

return {
	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		"/home/dima/.bun/install/global/node_modules/typescript/lib",
		"--ngProbeLocations",
		"/home/dima/.bun/install/global/node_modules/@angular/language-server/bin",
	},
	root_dir = root,
}
