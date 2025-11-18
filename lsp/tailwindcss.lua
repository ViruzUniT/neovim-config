local root = vim.fs.dirname(vim.fs.find({
	"tsconfig.json",
	"package.json",
	".git",
}, { upward = true })[1])

return {
	filetypes = { "html", "typescriptreact" },
	cmd = { "tailwindcss-language-server" },
	root_dir = root,
}
