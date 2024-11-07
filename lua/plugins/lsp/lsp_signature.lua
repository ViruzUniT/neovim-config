-- return {}
return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = function(_, opts)
    vim.keymap.set({ 'i', 'v', 's' }, '<M-x>', function()
      print("M-x presed")
      require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, buffer = bufnr, desc = 'toggle signature' })
  end
}
