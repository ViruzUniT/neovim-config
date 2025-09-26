local cfg = {
	cmd = { "gopls" },
	filetypes = { "go", "gomode", "gowork", "gompl" },
	root_markers = { { "go.mod", "go.sum" }, ".git" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
}
return cfg
