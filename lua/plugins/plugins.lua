require("lazy").setup({
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        keys = {"<leader>", "<c-r>", '"', "'", "`", "c", "v", "g"},
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-buffer"}, 
    {"hrsh7th/cmp-path"},
    {
        "numToStr/Comment.nvim",
        config = function ()
            require('Comment').setup()
        end
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {"saadparwaiz1/cmp_luasnip"}, 
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-nvim-lua"}, 
    {"nvim-lua/plenary.nvim"},
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function ()
                    local null_ls = require "null-ls"
                    null_ls.setup {
                        debug = true,
                        sources = sources,
                        on_attach = function(client, bufnr) 
                          if client.supports_method("textDocument/formatting") then
                            vim.api.nvim_clear_autocmds({
                              gruop = augroup,
                              buffer = bufnr,
                            })
                            vim.api.nvim_create_autocmd("BufWritePre", {
                              gruop = augroup,
                              buffer = bufnr,
                              callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                              end,
                            })
                          end
                        end,
                      }
                end
            }
        },
        config = function()
            --     require "plugins.config.lspconfig"
            --   require "plugins.custom.configs.lspconfig"
        end -- Override to setup mason-lspconfig
    }, -- override plugin configs
    {"williamboman/mason.nvim",
    config = function ()
        require("mason").setup()
    end
}, 
    {"williamboman/mason-lspconfig.nvim"},
    {"nvim-treesitter/nvim-treesitter",
    config = function ()
        require'nvim-treesitter.configs'.setup{
            ensure_installed = {
                "vim",
                "lua",
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "c",
                "markdown",
                "markdown_inline",
                "cpp"
              },
              highlight = {
                enable = true,
            
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
              },
              indent = {
                enable = true,
                -- disable = {
                --   "python"
                -- },
              },
        }
    end
    }, 
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        --config = function() require("better_escape").setup() end
        config = function ()
            require("better_escape").setup()
        end,
    },

    --themes
    {"rose-pine/neovim"},
    {"tomasr/molokai"},
    {"sainnhe/everforest"},

    {"sharkdp/fd"}, 
    {
        "theprimeagen/harpoon",
        config = function()
            local mark = require "harpoon.mark"
            local ui = require "harpoon.ui"

            vim.keymap.set("n", "<leader>a", mark.add_file,
                           {desc = "Harpoon add File"})
            vim.keymap.set("n", "<leader>qm", ui.toggle_quick_menu,
                           {desc = "Harpoon Quick Menu"})

            vim.keymap.set("n", "<C-e>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-m>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-a>", function() ui.nav_file(4) end)
        end,
        lazy = false
    }, 
    {"mbbill/undotree", lazy = false}, 
    {"tpope/vim-fugitive"},
    {"BurntSushi/ripgrep"}, 
    {"mfussenegger/nvim-dap"}, 
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
        opts = {
            handlers = {},
            ensure_installed = {"codelldb", "clangd", "clang-format"}
        }
    }, 
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapiu = require("dapui")
            dapiu.setup()
            dap.listeners.after.event_initialized["dapiu_config"] = function()
                dapiu.open()
            end
            dap.listeners.before.event_terminated["dapiu_config"] = function()
                dapiu.close()
            end
            dap.listeners.before.event_exited["dapiu_config"] = function()
                dapiu.close()
            end
        end
    }, 
    {"xiyaowong/transparent.nvim",
        opts =  {
          extra_groups =  {
            --"NormalFloat",
            --"NvimTreeNormal"
          }
        }
    }, 

    {
        "nvim-telescope/telescope.nvim",
       -- dependencies = "nvim-treesitter/nvim-treesitter"
    },
    {"vim-airline/vim-airline",
        dependencies = {"vim-airline/vim-airline-themes"},
        config = function ()
            vim.g["airline#extensions#tabline#enabled"] = 0
            vim.g["airline_theme"] = "bubblegum"
            vim.g["airline#extensions#tabline#left_sep"] = " "
            vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
            vim.g["airline_left_sep"] = ''
            vim.g["airline_left_alt_sep"] = ''
            vim.g["airline_right_sep"] = ''
            vim.g["airline_right_alt_sep"] = ''
            vim.g["airline_symbols.branch"] = ''
            vim.g["airline_symbols.readonly"] = ''
            vim.g["airline_symbols.linenr"] = '☰'
            vim.g["airline_symbols.maxlinenr"] = ''
            vim.g["airline_symbols.dirty"]='⚡'
            
        end
    }
})
