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
        "lua_ls",
        "kotlin_language_server",
        "ktlint"
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    -- opts = {
    --   servers = {
    --     kotlin_language_server = {}
    --   }
    -- },
    config = function()
      local mason = require("mason")
      local mason_lsp = require("mason-lspconfig")
      
      opts = {
        servers = {
          kotlin_language_server = {},
          jdtls = {}
        }
      }

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        jdtls = function()
          return true
        end,
        ensure_installed = {
          "lua_ls",
          "clangd",
          "kotlin_language_server",
          "java-debug-adapter", 
          "java-test",
        },        
       
        automatic_installation = true,
      })
    end
  },
}
