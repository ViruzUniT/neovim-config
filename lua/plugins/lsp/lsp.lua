local config = function()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local _on_attach = function(_, _) end

	vim.cmd("LspStart")
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Goto Declaration" })
			vim.keymap.set(
				"n",
				"gd",
				"<cmd> Telescope lsp_definitions<CR>",
				{ buffer = ev.buf, desc = "Goto Definition" }
			)
			if vim.bo.filetype ~= "rust" then
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
			end
			vim.keymap.set(
				"n",
				"<leader>gi",
				"<cmd> Telescope lsp_implementations<CR>",
				{ buffer = ev.buf, desc = "Show Implementations" }
			)

			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
			end, { buffer = ev.buf, desc = "List Workleader Folders" })
			vim.keymap.set(
				"n",
				"<leader>D",
				vim.lsp.buf.type_definition,
				{ buffer = ev.buf, desc = "Goto Type Definition" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = ev.buf, desc = "Code Action" }
			)
			vim.keymap.set(
				"n",
				"gr",
				"<cmd> Telescope lsp_references<CR>",
				{ buffer = ev.buf, desc = "Show References" }
			)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = ev.buf, desc = "Format" })
		end,
	})

	local capabilities = cmp_nvim_lsp.default_capabilities()
	capabilities.offsetEncoding = { "utf-16" }

	lspconfig["lua_ls"].setup({
		on_attach = _on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				hint = { enable = true },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
		filetypes = { "lua" },
	})

	function OpenHeaderFile()
		local filename = vim.fn.expand("%:t") -- Get the current file name
		local filepath = vim.fn.expand("%:p:h") -- Get the current file path
		local headername = filename:gsub("%.cpp$", ".h") -- Replace .cpp with .h

		if headername ~= filename then
			vim.cmd("set splitright")
			vim.cmd("vsplit " .. filepath .. "/../include" .. "/" .. headername)
		else
			print("Not a .cpp file or corresponding .h file doesn't exist")
		end
	end

	function OpenUnrealHeaderFile()
		local filename = vim.fn.expand("%:t") -- Get the current file name
		local filepath = vim.fn.expand("%:p:h") -- Get the current file path
		local headername = filename:gsub("%.cpp$", ".h") -- Replace .cpp with .h

		if headername ~= filename then
			vim.cmd("set splitright")
			vim.cmd("vsplit " .. filepath .. "/../Public/" .. "/" .. headername)
		else
			print("Not a .cpp file or corresponding .h file doesn't exist")
		end
	end

	lspconfig["clangd"].setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.signatureHelpProvider = true
			_on_attach(client, bufnr)
			vim.keymap.set("n", "gh", [[:lua OpenHeaderFile()<CR>]], { noremap = true, silent = true })
			vim.keymap.set("n", "gp", [[:lua OpenUnrealHeaderFile()<CR>]], { noremap = true, silent = true })
		end,
		cmd = {
			"clangd",
			"--header-insertion=never",
			"--background-index", --index every file in workspaces
			"--clang-tidy", -- additional linting and static analysis
			-- "--index-threads=4",           -- number of threads for SPEEED
			"--completion-style=detailed", -- detailed completion suggestions
		},
		root_dir = function()
			return vim.fn.getcwd()
		end,
		init_options = {
			fallbackFlags = { "--std=c++20" },
		},
		capabilities = capabilities,
		filetypes = { "c", "cpp", "h", "hpp" },
	})

	lspconfig.pyright.setup({ capabilities = capabilities })

	require("java").setup({
		jdk = {
			auto_install = false,
			path = "C:\\\\Program Files\\\\Common Files\\\\Oracle\\\\Java\\\\javapath\\\\java.exe",
		},
	})
	require("lspconfig").jdtls.setup({})

	lspconfig.ts_ls.setup({ capabilities = capabilities })
	lspconfig.emmet_language_server.setup({
		filetypes = {
			"css",
			"eruby",
			"html",
			"javascript",
			"javascriptreact",
			"less",
			"sass",
			"scss",
			"pug",
			"typescriptreact",
		},
		capabilities = capabilities,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = false },
			{ "antosha417/nvim-lsp-file-operations", lazy = false, config = true },
		},
		config = config,
	},
	{
		"nvim-java/nvim-java",
		config = false,
		lazy = false,
		dependencies = {
			{
				"neovim/nvim-lspconfig",
				opts = {
					servers = {
						jdtls = {},
					},
					setup = {
						jdtls = function()
							require("java").setup({
								jdk = {
									auto_install = false,
									path = "C:\\\\Program Files\\\\Common Files\\\\Oracle\\\\Java\\\\javapath\\\\java.exe",
								},
							})
							require("lspconfig").jdtls.setup({})
						end,
					},
				},
			},
		},
	},
}
