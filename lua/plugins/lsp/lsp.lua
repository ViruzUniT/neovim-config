vim.lsp.enable("lua_ls")
vim.lsp.enable("emmet")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("jdtls")
vim.lsp.enable("pyright")
vim.lsp.enable("ts_ls")

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
		-- if client:supports_method("textDocument/completion") then
		-- 	vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "popup" }
		-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		--
		-- 	vim.keymap.set("i", "<Tab>", function()
		-- 		if vim.fn.pumvisible() == 1 then
		-- 			return vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
		-- 		else
		-- 			return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
		-- 		end
		-- 	end, { expr = true, silent = true })
		-- 	vim.keymap.set("i", "<S-Tab>", function()
		-- 		if vim.fn.pumvisible() == 1 then
		-- 			return vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
		-- 		else
		-- 			return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
		-- 		end
		-- 	end, { expr = true, silent = true })
		--
		-- 	vim.keymap.set("i", "<C-Space>", function()
		-- 		vim.lsp.completion.get()
		-- 	end)
		-- end
		if client:supports_method("textDocument/rename") then
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
		end
	end,
})

return {}
