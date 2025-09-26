local function load_keymaps()
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

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local jdtls_path_to_plugins = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
local jdtls_path_to_jar = vim.fn.glob(jdtls_path_to_plugins .. "plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_lombok_path = jdtls_path_to_plugins .. "lombok.jar"
local jdtls_project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/"
local jdtls_path_to_lsp_server

if vim.loop.os_uname().sysname ~= "Linux" then
	jdtls_path_to_lsp_server = jdtls_path .. "/config_win"
else
	jdtls_path_to_lsp_server = jdtls_path .. "/config_linux"
end

local cfg = {
	on_attach = function(_)
		-- local jdtls_root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
		-- local jdtls_root_dir = require("jdtls.setup").find_root(jdtls_root_markers)
		-- local jdtls_root_dir = vim.fn.getcwd()
		-- end

		local jdtls_project_dir = jdtls_workspace_dir .. jdtls_project_name
		if vim.loop.os_uname().sysname ~= "Linux" then
			os.execute("rmdir " .. jdtls_project_dir)
		else
			os.execute("rm -rf " .. jdtls_project_dir)
		end
		vim.fn.mkdir(jdtls_workspace_dir, "p")
	end,
	filetypes = { "java" },
	root_markers = { { "mvnw", "gradlew", "pom.xml", "build.gradle" }, ".git" },
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. jdtls_lombok_path,
		"-Xms3g",
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
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
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
}
load_keymaps()
return cfg
