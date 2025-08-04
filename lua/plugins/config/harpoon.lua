local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu, { desc = "Harpoon Quick Menu" })

vim.keymap.set("n", "<C-e>", function()
  ui.nav_file(1)
end, { noremap = true })
vim.keymap.set("n", "<C-t>", function()
  ui.nav_file(2)
end, { noremap = true })
vim.keymap.set("n", "<C-m>", function()
  ui.nav_file(3)
end, { noremap = true })
vim.keymap.set("n", "<C-s>", function()
  ui.nav_file(4)
end, { noremap = true })

