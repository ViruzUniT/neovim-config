return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
      config = function()
        local mason = require("mason")
        local mason_lsp = require("mason-lspconfig")

        -- enable mason and configure icons
        mason_lsp.setup({
          automatic_installation = true,
          ensure_installed = {
            "clang-format",
            "rust_analyzer",
            "lua_ls",
            "lua_ls",
            "clangd",
            -- "java_debug_adapter",
            "jdtls",
            -- "java_test",
            "pyright",
            "ruff",
            "mypy",
            "debugpy",
            "black",
          },
        })
      end
    },
  } }
