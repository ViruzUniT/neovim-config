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
  {
    "mfussenegger/nvim-jdtls",
opts = function()
  local mason_registry = require("mason-registry")
  local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
  return {
    -- How to find the root dir for a given filename. The default comes from
    -- lspconfig which provides a function specifically for java projects.
    root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

    -- How to find the project name for a given root dir.
    project_name = function(root_dir)
      return root_dir and vim.fs.basename(root_dir)
    end,

    -- Where are the config and workspace dirs for a project?
    jdtls_config_dir = function(project_name)
      return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
    end,
    jdtls_workspace_dir = function(project_name)
      return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
    end,

    -- How to run jdtls. This can be overridden to a full java command-line
    -- if the Python wrapper script doesn't suffice.
    cmd = {
      vim.fn.exepath("jdtls"),
      string.format("--jvm-arg=-javaagent:%s", lombok_jar),
    },
    full_cmd = function(opts)
      local fname = vim.api.nvim_buf_get_name(0)
      local root_dir = opts.root_dir(fname)
      local project_name = opts.project_name(root_dir)
      local cmd = vim.deepcopy(opts.cmd)
      if project_name then
        vim.list_extend(cmd, {
          "-configuration",
          opts.jdtls_config_dir(project_name),
          "-data",
          opts.jdtls_workspace_dir(project_name),
        })
      end
      return cmd
    end,

    -- These depend on nvim-dap, but can additionally be disabled by setting false here.
    dap = { hotcodereplace = "auto", config_overrides = {} },
    dap_main = {},
    test = true,
    settings = {
      java = {
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },
      },
    },
  }
end
  },
} 
