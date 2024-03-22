return {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = {},
    config = function(_, _)
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, _)
            print("niggr")
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions)
            vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group,
              { desc = "Rust Code Action" })
            vim.keymap.set("n", "gE", rt.expand_macro.expand_macro, { desc = "Rust Expand Macro" })
            vim.keymap.set("n", "gP", rt.parent_module.parent_module, { desc = "Rust Parent Module" })
          end
        }
      })
    end
  }
}
