return {
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
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = 'horizon',
        component_separators = '',
        section_separators = {left = '', right = ''}
      },
      sections = {
        lualine_a = {
          {
            'buffers',
            draw_empty = false,
            use_mode_colors = true
          },
        },
        lualine_c = {
          "os.date('%X, %x')", 'data', "require'lsp-status'.status()"
        }
      }
    }
  end
}
