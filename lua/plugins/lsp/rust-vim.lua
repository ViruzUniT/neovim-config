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
      local mason_registry = require("mason-registry")

      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

      rt.setup({
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          on_attach = function(_, _)
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions)
            vim.keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group,
              { desc = "Rust Code Action" })
            vim.keymap.set("n", "gE", rt.expand_macro.expand_macro, { desc = "Rust Expand Macro" })
            vim.keymap.set("n", "gP", rt.parent_module.parent_module, { desc = "Rust Parent Module" })
          end
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          }
        }
      })
    end
  }
}
