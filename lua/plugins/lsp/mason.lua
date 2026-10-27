return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			-- Roslyn is published through the community registry below.
			registries = {
				"github:Crashdummyy/mason-registry",
				"github:mason-org/mason-registry",
			},
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
			local registry = require("mason-registry")
			-- Install Roslyn once the custom registry has been refreshed.  Mason
			-- will simply skip this when it is already installed.
			vim.defer_fn(function()
				local ok, package = pcall(registry.get_package, "roslyn")
				if ok and not package:is_installed() and not package:is_installing() then
					package:install()
				end
			end, 1000)

			local mason_lsp = require("mason-lspconfig")

			-- enable mason and configure icons
			mason_lsp.setup({
				automatic_installation = false,
				automatic_enable = {
					exclude = { "clangd", "jdtls", "gopls" },
				},
				ensure_installed = {
					"tailwindcss",
					"rust_analyzer",
					"lua_ls",
					"clangd",
					"pyright",
					"ts_ls",
					"emmet_language_server",
					"jdtls",
					"gopls",
					"angularls",
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			local ensure_installed = {
				"prettier",
				"clang-format",
				"stylua",
				"black",
				"gofmt",
				"goimports",
				"golines",
				"google-java-format",
				"codelldb",
			}
			require("mason-null-ls").setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "python", "javadbg", "delve" },
				automatic_installation = true,
			})
		end,
	},
}
