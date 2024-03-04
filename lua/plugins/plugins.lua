--require("lazy").setup({
return {
-- "hrsh7th/cmp-nvim-lsp",
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",     -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
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
}--)
