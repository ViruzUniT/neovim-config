return {
  "ViruzUniT/lsp_signature.nvim",
  event = "VeryLazy",
  config = function(_, _)
    require('lsp_signature').setup({
      toggle_key = '<C-k>',
      bind = true,
      handler_opts = {
        border = "rounded"
      },
      floating_window = false,
    }
    )
    -- vim.keymap.set({ 'i', 'v', 's' }, '<C-k>', function()
    --   require('lsp_signature').signature()
    -- end, { silent = true, noremap = true, buffer = bufnr, desc = 'toggle signature' })
  end
}
