return {
  "ray-x/lsp_signature.nvim",
  -- lazy = false;
  event = "InsertEnter",
  config = function(_, _opts)
    require('lsp_signature').toggle_float_win()
    vim.keymap.set({ 'i', 'v', 's' }, '<C-k>', function()
      require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, buffer = bufnr, desc = 'toggle signature' })
  end
}
