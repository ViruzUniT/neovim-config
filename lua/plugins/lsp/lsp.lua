vim.lsp.enable("lua_ls")

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

vim.cmd([[
highlight DiagnosticUnderlineError gui=underline guisp=Red
highlight DiagnosticUnderlineWarn gui=underline guisp=Yellow
highlight DiagnosticUnderlineInfo gui=underline guisp=Blue
highlight DiagnosticUnderlineHint gui=underline guisp=Green
]])

vim.opt.winborder = "rounded"

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

			vim.keymap.set("i", "<Tab>", function()
				return vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<S-Tab>", function()
				return vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
			end, { expr = true, silent = true })

			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
	end,
})

return {}
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = {
--     {
--       "folke/lazydev.nvim",
--       ft = "lua",
--       opts = {
--         library = {
--           { path = "${3rd}/luv/library", words = { "vim%.uv" } },
--         },
--       },
--     },
--   },
--   lazy = false,
--   config = function()
--     local lspconfig = require("lspconfig")
--     local cmp = require("cmp_nvim_lsp")
--     local capabilities = cmp.default_capabilities()
--     capabilities.offsetEncoding = { "utf-16" }
--
--     require("plugins.lsp.config.remaps")
--     lspconfig.clangd.setup(require("plugins.lsp.config.clang").setup(capabilities))
--     lspconfig.jdtls.setup(require("plugins.lsp.config.jdtls").setup(capabilities))
--     lspconfig.gopls.setup(require("plugins.lsp.config.gopls").setup(capabilities))
--     lspconfig.ts_ls.setup({ capabilities = capabilities })
--     lspconfig.pyright.setup({ capabilities = capabilities })
--   end,
-- }
