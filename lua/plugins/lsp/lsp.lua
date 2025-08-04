local cmp_nvim_lsp = require("cmp_nvim_lsp")
local config = function()
	local lspconfig = require("lspconfig")
	local util = require("lspconfig/util")

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
				vim.lsp.buf.format({})
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
			fallbackFlags = {
				"--std=c++23",
				"--std=c23",
			},
		},
		capabilities = capabilities,
		filetypes = { "c", "cpp", "h", "hpp" },
	})

	local jdtls_path = vim.fn.stdpath("data") .. "\\mason\\packages\\jdtls"
	local jdtls_path_to_lsp_server = jdtls_path .. "\\config_win"
	local jdtls_path_to_plugins = vim.fn.stdpath("data") .. "\\mason\\packages\\jdtls\\"
	local jdtls_path_to_jar = jdtls_path_to_plugins .. "plugins\\org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar"
	local jdtls_lombok_path = jdtls_path_to_plugins .. "lombok.jar"

	local jdtls_root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
	local jdtls_root_dir = require("jdtls.setup").find_root(jdtls_root_markers)
	if jdtls_root_dir == "" then
		return
	end

	local jdtls_project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local jdtls_workspace_dir = vim.fn.stdpath("data") .. "\\site\\java\\workspace-root\\"
	local jdtls_project_dir = jdtls_workspace_dir .. jdtls_project_name
	os.execute("rmdir " .. jdtls_workspace_dir)
	os.execute("mkdir " .. jdtls_project_dir)

	lspconfig["jdtls"].setup({
		-- cmd = {},
		cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-javaagent:" .. jdtls_lombok_path,
			"-Xms1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			"-jar",
			jdtls_path_to_jar,
			"-configuration",
			jdtls_path_to_lsp_server,
			"-data",
			jdtls_workspace_dir,
		},

		settings = {
			java = {
				-- home = "/Users/ivanermolaev/Library/Java/vi/temurin-18.0.1/Contents/Home/",
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "interactive",
					-- runtimes = {
					-- 	{
					-- 		name = "JavaSE-21",
					-- 		path = "C:/jdk-22.0.4",
					-- 	},
					-- 		{
					-- 			name = "JavaSE-17",
					-- 			path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-17.0.4/Contents/Home",
					-- 		},
					-- 	},
					-- },
					maven = {
						downloadSources = true,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					format = {
						enabled = false,
						settings = {
							url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
				},
				signatureHelp = { enabled = true },
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.hamcrest.CoreMatchers.*",
						"org.junit.jupiter.api.Assertions.*",
						"java.util.Objects.requireNonNull",
						"java.util.Objects.requireNonNullElse",
						"org.mockito.Mockito.*",
					},
					importOrder = {
						"java",
						"javax",
						"com",
						"org",
					},
				},
				extendedClientCapabilities = require("cmp_nvim_lsp").default_capabilities(),
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
			},

			flags = {
				allow_incremental_sync = true,
			},
			init_options = {
				bundles = {},
			},
		},
	})

	lspconfig.pyright.setup({ capabilities = capabilities })

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

	lspconfig.gopls.setup({
		on_attach = _on_attach,
		capabilities = capabilities,
		cmd = { "gopls" },
		filetypes = { "go", "gomode", "gowork", "gotmpl" },
		root_dir = util.root_pattern("go.work", "go.mod"),
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
			},
		},
	})

	-- java
	vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
	vim.keymap.set(
		"n",
		"<leader>crv",
		"<Cmd>lua require('jdtls').extract_variable()<CR>",
		{ desc = "Extract Variable" }
	)
	vim.keymap.set(
		"v",
		"<leader>crv",
		"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
		{ desc = "Extract Variable" }
	)
	vim.keymap.set(
		"n",
		"<leader>crc",
		"<Cmd>lua require('jdtls').extract_constant()<CR>",
		{ desc = "Extract Constant" }
	)
	vim.keymap.set(
		"v",
		"<leader>crc",
		"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
		{ desc = "Extract Constant" }
	)
	vim.keymap.set(
		"v",
		"<leader>crm",
		"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
		{ desc = "Extract Method" }
	)
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
}
