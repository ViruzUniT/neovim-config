--require("lazy").setup({
return {
  -- "hrsh7th/cmp-nvim-lsp",
  {
    "nvim-tree/nvim-tree.lua",
    config = function ()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      
      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true
      
      -- empty setup using defaults
      require("nvim-tree").setup()
      
      -- OR setup with some options
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    dependencies = { "dhawton/vsc-fivem", "JericoFX/QBCore-FX-Snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  { "nvim-lua/plenary.nvim" },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    --config = function() require("better_escape").setup() end
    config = function()
      require("better_escape").setup()
    end,
  },
  { "sharkdp/fd" },
  { "BurntSushi/ripgrep" },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "TreesitterContext"
        --"NormalFloat",
        --"NvimTreeNormal"
      }
    },
    lazy = false
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy"
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
} --)
