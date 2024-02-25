vim.g.mapleader = " "
local wk = require("which-key")

local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

vim.keymap.set("n", "<C-e>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-m>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-a>", function() ui.nav_file(4) end)

wk.register({
  p = {
    name = "Project",
    v = {vim.cmd.Ex, "Explorer"},
    f = { "<cmd> Telescope find_files <CR>", "Find Files", noremap = true },
    s = { "<cmd> Telescope live_grep <cr>", "Live Grep", noremap = true },
  },

  a = {mark.add_file, "Harpoon add File"},
  q = {
    name = "Harpoon",
    m = {ui.toggle_quick_menu, "Quick Menu"}
  },

  d =  {
    name = "Dapui",
    d = { '"_d', "Delete foreveer", noremap = true },
    b = { "<cmd> DapToggleBreakpoint <CR>", "Toggle Breakpoint at Line", noremap = true },
    r = { "<cmd> DapContinue <CR>", "Start or Continue Debugger", noremap = true },
  },
  y =  { '"+y', "Copy to clipboard" },
  u =  { vim.cmd.UndotreeToggle, "Toggle Undotree" },

  ["/"] = {
    function()
      require("Comment.api").toggle.linewise.current()
    end, "Toggle Comment"
  }
  
}, {prefix = "<leader>"})

wk.register({ 
  d = { '"_d', "Delete forever" },
  y = { '"+y', "Copy to Clipboard" },

  ["/"] = {"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  "Toggle comment", noremap = true}

}, { mode = "v", prefix = "<leader>" })


wk.register({ 
  p = { '"_dP', "Replace without copy" },

}, { mode = "x", prefix = "<leader>" })

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

function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Map("i", "<", "<><left>")
--Map("i", "<<", "<< ")
-- Map("i", "(", "()<left>")
Map("i", "(/", "() {<CR> <CR>}<up> ", { noremap = true })
Map("i", "(;", "();<left><left>")
-- Map("i", "[", "[]<left>")
Map("i", "{", "{  }<left><left>", { noremap = true })
Map("i", "{<CR>", " {<CR> <CR>}<up> ")
Map("i", "{;", "{<CR> <CR>};<up> ")
