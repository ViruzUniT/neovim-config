return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "VeryLazy",
  opts = function ()
    return require "core.configs.null-ls"
  end,
}
