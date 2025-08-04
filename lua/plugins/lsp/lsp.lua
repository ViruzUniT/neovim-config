return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  lazy = false,
  config = function()
    local lspconfig = require("lspconfig")
    local cmp = require("cmp_nvim_lsp")
    local capabilities = cmp.default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    require("plugins.lsp.config.remaps")
    lspconfig.clangd.setup(require("plugins.lsp.config.clang").setup(capabilities))
    lspconfig.jdtls.setup(require("plugins.lsp.config.jdtls").setup(capabilities))
    lspconfig.gopls.setup(require("plugins.lsp.config.gopls").setup(capabilities))
    lspconfig.ts_ls.setup({ capabilities = capabilities })
    lspconfig.pyright.setup({ capabilities = capabilities })
  end,
}
