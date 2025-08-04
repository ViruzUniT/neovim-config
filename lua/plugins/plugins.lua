return {
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css" },
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    dependencies = { "tpope/vim-fugitive", lazy = false },
    lazy = false,
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" } },
    },
  },
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add File" })
      vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu, { desc = "Harpoon Quick Menu" })

      vim.keymap.set("n", "<C-e>", function()
        ui.nav_file(1)
      end, { noremap = true })
      vim.keymap.set("n", "<C-t>", function()
        ui.nav_file(2)
      end, { noremap = true })
      vim.keymap.set("n", "<C-m>", function()
        ui.nav_file(3)
      end, { noremap = true })
      vim.keymap.set("n", "<C-s>", function()
        ui.nav_file(4)
      end, { noremap = true })
    end,
    VeryLazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    config = function()
      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      -- pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension("remote-sshfs"))
    end,
  },
  -- {
  -- 	"nvim-tree/nvim-tree.lua",
  -- 	config = function()
  -- 		-- disable netrw at the very start of your init.lua
  -- 		vim.g.loaded_netrw = 1
  -- 		vim.g.loaded_netrwPlugin = 1
  --
  -- 		-- optionally enable 24-bit colour
  -- 		vim.opt.termguicolors = true
  --
  -- 		-- empty setup using defaults
  -- 		-- require("nvim-tree").setup()
  --
  -- 		-- OR setup with some options
  -- 		require("nvim-tree").setup({
  -- 			sort = {
  -- 				sorter = "case_sensitive",
  -- 			},
  -- 			view = {
  -- 				width = 30,
  -- 			},
  -- 			renderer = {
  -- 				group_empty = true,
  -- 			},
  -- 			filters = {
  -- 				dotfiles = true,
  -- 			},
  -- 		})
  -- 	end,
  -- },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "dhawton/vsc-fivem", "JericoFX/QBCore-FX-Snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "sharkdp/fd" },
  { "BurntSushi/ripgrep" },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "TreesitterContext",
        "LineNr",
      },
    },
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
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
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    opts = {},
    lazy = false,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig",      -- optional
    },
    opts = {},                      -- your configuration
  },
}
