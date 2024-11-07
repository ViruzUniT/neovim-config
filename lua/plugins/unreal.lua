return {
  "zadirion/Unreal.nvim",
  lazy = false,
  dependencies = { { "tpope/vim-dispatch", lazy = false } },
  config = function()
    vim.g.unrealnvim_debug = true;
  end
}
