return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
    opts = {
      ensure_installed = {
        "clang-format",
        "rust-analyzer",
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local mason = require("mason")
      local mason_lsp = require("mason-lspconfig")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        -- ensure_installed = {
        --   "clang-format"
        -- }
      })

      mason_lsp.setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
        },
        automatic_installation = true,
      })
    end
  },
}
