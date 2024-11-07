return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  keys = { "<leader>", "<c-r>", '"', "'", "`", "c", "v", "g" },
  config = function()
    local wk = require("which-key")
    local mark = require "harpoon.mark"
    local ui = require "harpoon.ui"

    vim.keymap.set('n', '<C-n>', "<cmd> NvimTreeToggle<CR>")
    wk.register({
      l = {
        name = "LSP",
        i = {
          "<cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) <CR>",
          "Toggle Inlay Hints",
          noremap = true
        }
      },
      p = {
        name = "Project",
        v = { vim.cmd.Ex, "Explorer" },
        f = { "<cmd> Telescope find_files <CR>", "Find Files", noremap = true },
        s = { "<cmd> Telescope live_grep <cr>", "Live Grep", noremap = true },
      },

      a = { mark.add_file, "Harpoon add File" },
      q = {
        name = "Harpoon",
        m = { ui.toggle_quick_menu, "Quick Menu" }
      },

      d = {
        name = "Dapui",
        d = { '"_d', "Delete foreveer", noremap = true },
        b = { "<cmd> DapToggleBreakpoint <CR>", "Toggle Breakpoint at Line", noremap = true },
        r = {
          "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustDebuggables]] else require'dap'.continue() end<CR>",
          "Start or Continue Debugger",
          noremap = true
        },
      },
      y = { '"+y', "Copy to clipboard" },
      u = { vim.cmd.UndotreeToggle, "Toggle Undotree" },

      t = {
        name = "Trouble",
        d = { '<cmd>Trouble diagnostics<cr>', "Toggle Trouble Diagnostics" },
        -- w = {'<cmd>TroubleToggle workspace_diagnostics<cr>', "Toggle Trouble Work Diagnostics"},
        -- r = {'<cmd>TroubleToggle lsp_references<cr>', "Toggle Trouble LSP References"},
        -- e = {'<cmd>TroubleToggle lsp_definitions<cr>', "Toggle Trouble LSP Definitions"},
        -- t = {'<cmd>TroubleToggle lsp_type_definitions<cr>', "Toggle Trouble LSP Type Definitions"},
        -- q = {'<cmd>TroubleToggle quickfix<cr>', "Toggle Trouble Quickfix"},
        -- l = {'<cmd>TroubleToggle loclist<cr>', "Toggle Trouble Location List"},
      },

      ["/"] = {
        function()
          require("Comment.api").toggle.linewise.current()
        end, "Toggle Comment"
      }

    }, { prefix = "<leader>" })

    wk.register({
      d = { '"_d', "Delete forever" },
      y = { '"+y', "Copy to Clipboard" },

      ["/"] = {
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        "Toggle comment",
        noremap = true
      }

    }, { mode = "v", prefix = "<leader>" })


    wk.register({
      p = { '"_dP', "Replace without copy" },

    }, { mode = "x", prefix = "<leader>" })
  end
}
