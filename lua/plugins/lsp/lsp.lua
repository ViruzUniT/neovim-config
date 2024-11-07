local config = function()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local _on_attach = function(_, _)
  end

  vim.cmd("LspStart")
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    --on_attach = on_attach,
    --capabilities = capabilities
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        { buffer = ev.buf, desc = "Goto Declaration" })
      vim.keymap.set('n', 'gd', "<cmd> Telescope lsp_definitions<CR>", --vim.lsp.buf.definition,
        { buffer = ev.buf, desc = "Goto Definition" })
      if vim.bo.filetype ~= 'rust' then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover,
          { buffer = ev.buf, desc = "Hover" })
      end
      vim.keymap.set('n', '<leader>gi', "<cmd> Telescope lsp_implementations<CR>", --vim.lsp.buf.implementation,
        { buffer = ev.buf, desc = "Show Implementations" })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
        { buffer = ev.buf, desc = "Singnature Help" })
      -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf })
      -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf })
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
      end, { buffer = ev.buf, desc = "List Workleader Folders" })
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
        { buffer = ev.buf, desc = "Goto Type Definition" })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        { buffer = ev.buf, desc = "Rename" })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
        { buffer = ev.buf, desc = "Code Action" })
      vim.keymap.set('n', 'gr', "<cmd> Telescope lsp_references<CR>", --vim.lsp.buf.references,
        { buffer = ev.buf, desc = "Show References" })
      vim.keymap.set('n', '<leader>f',
        function() vim.lsp.buf.format { async = true } end,
        { buffer = ev.buf, desc = "Format" })
    end
  })

  local capabilities = cmp_nvim_lsp.default_capabilities()
  capabilities.offsetEncoding = { "utf-16" }

  lspconfig["lua_ls"].setup({
    on_attach = _on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
        hint = { enable = true }
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        }
      }
    },
    filetypes = { "lua" }
  })

  lspconfig["clangd"].setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.signatureHelpProvider = true
      _on_attach(client, bufnr)
    end,
    cmd = {
      "clangd",
      "--header-insertion=never",
    },
    init_options = {
      fallbackFlags = { '--std=c++20' }
    },
    capabilities = capabilities,
    filetypes = { "c", "cpp", "h", "hpp" }
  })

  lspconfig.pyright.setup {}
  lspconfig.jdtls.setup {
    filetypes = { "java" },
    on_attach = function(_, _)
      print("yay")
      local cfg = {
        cmd = { "jdtls" },
        root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
      }
      require('jdtls').start_or_attach(cfg)
    end,
  }
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp",                lazy = false },
    { "antosha417/nvim-lsp-file-operations", lazy = false, config = true }
  },
  opts = {
    servers = {
      kotlin_language_server = {},
    }
  },
  config = config
}
