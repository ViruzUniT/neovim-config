local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
	capabilities = capabilities,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },

	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
