return {
  "theprimeagen/harpoon",
  config = function()
    local mark = require "harpoon.mark"
    local ui = require "harpoon.ui"

    vim.keymap.set("n", "<leader>a", mark.add_file,
      { desc = "Harpoon add File" })
    vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu,
      { desc = "Harpoon Quick Menu" })

    vim.keymap.set("n", "<C-e>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-m>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-a>", function() ui.nav_file(4) end)
  end,
  VeryLazy = true
}
