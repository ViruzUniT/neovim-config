function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

Map("n", ";", ":", { nowait = true })
Map("n", "J", "mzJ`z", { noremap = true, silent = true })
Map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
Map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
Map("n", "n", "nzzzv", { noremap = true, silent = true })
Map("n", "N", "Nzzzv", { noremap = true, silent = true })
Map("n", "Q", "<nop>", { noremap = true, silent = true })
Map("n", "q", "<nop>", { noremap = true, silent = true })
Map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
Map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
Map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
Map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
Map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
Map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

--Map("i", "<", "<><left>")
--Map("i", "<<", "<< ")
-- Map("i", "(", "()<left>")
Map("i", "(/", "() {<CR> <CR>}<up> ", { noremap = true })
Map("i", "(;", "();<left><left>")
-- Map("i", "[", "[]<left>")
Map("i", "{", "{  }<left><left>", { noremap = true })
--Map("i", "{<CR>", " {<CR> <CR>}<up> ")
Map("i", "{;", "{<CR> <CR>};<up> ")
