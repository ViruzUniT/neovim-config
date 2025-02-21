vim.keymap.set("n", "+", "<C-S>", { desc = "Increment Number" })
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })
vim.keymap.set("n", "q", "<nop>", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("i", "(/", "() {<CR> <CR>}<up> ", { noremap = true })
vim.keymap.set("i", "(;", "();<left><left>")
vim.keymap.set("i", "{", "{  }<left><left>", { noremap = true })
vim.keymap.set("i", "{;", "{<CR> <CR>};<up> ")
