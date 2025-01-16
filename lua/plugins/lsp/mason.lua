return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			local mason_lsp = require("mason-lspconfig")

			-- enable mason and configure icons
			mason_lsp.setup({
				automatic_installation = true,
				ensure_installed = {
					"rust_analyzer",
					"lua_ls",
					"lua_ls",
					"clangd",
					"jdtls",
					"pyright",
					"ts_ls",
					"emmet_language_server",
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"prettier",
					"clang-format",
					"stylua",
					"black",
				},
			})
		end,
	},
}
