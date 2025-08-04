vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.guicursor = "i:block"

vim.opt.updatetime = 700

if vim.loop.os_uname().sysname ~= "Linux" then
	vim.cmd("lang en_US")
end

vim.cmd("colorscheme modus")

vim.o.timeout = true
vim.o.timeoutlen = 300

vim.g.have_nerd_font = true
vim.opt.smartcase = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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
