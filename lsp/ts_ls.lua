local root = vim.fs.dirname(vim.fs.find({
	"tsconfig.json",
	"package.json",
	".git",
}, { upward = true })[1])

return {
	filetypes = { "typescript" },
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = root,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
}
