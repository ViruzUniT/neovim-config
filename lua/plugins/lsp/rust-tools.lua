return {
  "mrcjkb/rustaceanvim",
  ft = "rust",
  version = '^5',
  lazy = false,
  dependencies = "neovim/nvim-lspconfig",
  opts = {},
  config = function(_, _)
    vim.g.rustaceanvim = {
      tools = {
        hover_actions = {
          auto_focus = true,
        }
      },
      server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "K", vim.cmd.RustLsp { 'hover', 'actions' }, { buffer = bufnr})
          vim.keymap.set("n", "<leader>ca", vim.cmd.RustLsp('codeAction'),
            { desc = "Rust Code Action" , buffer = bufnr})
          vim.keymap.set("n", "<leader>Re", vim.cmd.RustLsp("expandMacro"), { desc = "Rust Expand Macro" , buffer = bufnr})
          vim.keymap.set("n", "<leader>Rp", vim.cmd.RustLsp("parentModule"), { desc = "Rust Parent Module" , buffer = bufnr})
          vim.keymap.set("n", "<leader>RR", function()
            vim.cmd("wa")
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables" })
          -- vim.keymap.set("n", "<leader>Rr", function()
          --   vim.cmd("wa")
          --   vim.cmd("RustRun")
          -- end, { desc = "Rust Run" })
        end
      }
    }
  end
}
