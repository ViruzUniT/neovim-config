return {
	"justinlazarus/roslyn.nvim",
	ft = { "cs" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		-- Roslyn uses EditorConfig-style settings rather than clang-format YAML.
		-- These are the closest C# equivalents to the requested style.
		vim.lsp.config("roslyn", {
			settings = {
				["csharp|formatting"] = {
					dotnet_organize_imports_on_format = false,
				},
			},
		})

		local format_group = vim.api.nvim_create_augroup("RoslynCSharpFormatting", {})
		vim.api.nvim_create_autocmd("FileType", {
			group = format_group,
			pattern = "cs",
			callback = function(args)
				vim.bo[args.buf].expandtab = true
				vim.bo[args.buf].shiftwidth = 4
				vim.bo[args.buf].tabstop = 4
			end,
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = format_group,
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client or client.name ~= "roslyn" or not client:supports_method("textDocument/formatting") then
					return
				end
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = format_group,
					buffer = args.buf,
					callback = function()
						vim.lsp.buf.format({
							bufnr = args.buf,
							filter = function(format_client)
								return format_client.id == client.id
							end,
							timeout_ms = 2000,
							formatting_options = {
								tabSize = 2,
								insertSpaces = true,
								trimTrailingWhitespace = true,
								insertFinalNewline = true,
								trimFinalNewlines = true,
								-- Roslyn has no clang-format alignment mode; keep argument
								-- lists compact and let the 98-column limit wrap them.
								maxLineLength = 98,
							},
						})
					end,
				})
			end,
		})

		require("roslyn").setup({
			filewatching = "auto",
			broad_search = true,
			fast_init = true,
		})
	end,
}
