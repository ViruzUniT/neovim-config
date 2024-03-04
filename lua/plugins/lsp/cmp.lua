return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua"
  },

  config = function()
    local cmp = require("cmp")
    local LuaSnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    --local cmp = require 'cmp'

    local function border(hl_name)
      return {
        { "╭", hl_name }, { "─", hl_name }, { "╮", hl_name }, { "│", hl_name },
        { "╯", hl_name }, { "─", hl_name }, { "╰", hl_name }, { "│", hl_name }
      }
    end

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        completion = { scrollbar = false },
        documentation = {
          border = border "CmpDocBorder",
          winhighlight = "Normal:CmpDoc"
        }
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
              "<Plug>luasnip-expand-or-jump", true, true,
              true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                "<Plug>luasnip-jump-prev", true, true, true),
              "")
          else
            fallback()
          end
        end, { "i", "s" })
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
  }, { { name = 'buffer' } })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' } -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, { { name = 'buffer' } })
    })

    local null_ls = require "null-ls"

    local b = null_ls.builtins

    local sources = {

      -- webdev stuff
      b.formatting.deno_fmt,                                                -- choosed deno for ts/js files cuz its very fast!
      b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

      -- Lua
      b.formatting.stylua,

      -- cpp
      b.formatting.clang_format,

    }

    -- null_ls.setup {
    --   debug = true,
    --   sources = sources,
    --   on_attach = function(client, bufnr)
    --     if client.supports_method("textDocument/formatting") then
    --       vim.api.nvim_clear_autocmds({
    --         gruop = augroup,
    --         buffer = bufnr,
    --       })
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         gruop = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --           vim.lsp.buf.format({ bufnr = bufnr })
    --         end,
    --       })
    --     end
    --   end,
    -- }
  end
}
