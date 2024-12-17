return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    -- vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>")
    -- vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>")
    -- vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", {desc = "Delete Current Buffer"})
    require("lualine").setup {
      options = {
        icons_enabled = true,
        -- theme = 'horizon',
        theme = 'modus-vivendi',
        component_separators = { left = '', right = "" },
        section_separators = { left = '', right = '' },
        always_show_tabline = true,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            draw_empty = false,
            use_mode_colors = true
          },
        },
        lualine_c = {
          "filename", "os.date('%X, %x')", 'data', "require'lsp-status'.status()"
        }
      }
    }
  end
  -- "vim-airline/vim-airline",
  -- dependencies = { "vim-airline/vim-airline-themes" },
  -- lazy = false,
  -- config = function()
  --   vim.g["airline#extensions#tabline#enabled"] = 0
  --   vim.g["airline_theme"] = "bubblegum"
  --   vim.g["airline#extensions#tabline#left_sep"] = " "
  --   vim.g["airline#extensions#tabline#left_alt_sep"] = "|"
  --   vim.g["airline_left_sep"] = ''
  --   vim.g["airline_left_alt_sep"] = ''
  --   vim.g["airline_right_sep"] = ''
  --   vim.g["airline_right_alt_sep"] = ''
  --   vim.g["airline_symbols.branch"] = ''
  --   vim.g["airline_symbols.readonly"] = ''
  --   vim.g["airline_symbols.linenr"] = '☰'
  --   vim.g["airline_symbols.maxlinenr"] = ''
  --   vim.g["airline_symbols.dirty"] = '⚡'
  -- end
}
