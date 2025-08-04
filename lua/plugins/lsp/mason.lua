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
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local mason_lsp = require("mason-lspconfig")

      -- enable mason and configure icons
      mason_lsp.setup({
        automatic_installation = true,
        ensure_installed = {
          "tailwindcss",
          "rust_analyzer",
          "lua_ls",
          "clangd",
          "pyright",
          "ts_ls",
          "emmet_language_server",
          "jdtls",
          "gopls",
        },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local ensure_installed = {
        "prettier",
        "clang-format",
        "stylua",
        "black",
        "gofmt",
        "goimports",
        "golines",
        "google-java-format",
      }
      require("mason-null-ls").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "javadbg", "delve" },
        automatic_installation = true,
      })
    end,
  },
}
